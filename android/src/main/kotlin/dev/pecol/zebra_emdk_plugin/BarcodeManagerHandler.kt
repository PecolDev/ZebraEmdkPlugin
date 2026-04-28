package dev.pecol.zebra_emdk_plugin

import android.annotation.SuppressLint
import android.bluetooth.BluetoothDevice
import android.bluetooth.BluetoothManager
import android.content.Context
import com.symbol.emdk.barcode.BarcodeManager
import com.symbol.emdk.barcode.BarcodeManager.ConnectionState
import com.symbol.emdk.barcode.BarcodeManager.ScannerConnectionListener
import com.symbol.emdk.barcode.ScanDataCollection
import com.symbol.emdk.barcode.Scanner
import com.symbol.emdk.barcode.Scanner.StatusListener
import com.symbol.emdk.barcode.Scanner.DataListener
import com.symbol.emdk.barcode.ScannerException
import com.symbol.emdk.barcode.ScannerInfo
import com.symbol.emdk.barcode.StatusData
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class BarcodeManagerHandler : StreamHandler, MethodCallHandler, ScannerConnectionListener, StatusListener, DataListener {
    private val handlerName: String = "barcode_manager"
    private lateinit var barcodeManager: BarcodeManager

    fun setupChannels(messenger: BinaryMessenger){
        setupMethodChannel(messenger)
        setupEventChannel(messenger)
    }

    fun initializeHandler(barcodeManager : BarcodeManager){
        this.barcodeManager = barcodeManager
        barcodeManager.addConnectionListener(this)
    }

    // --------------------------- METHOD CHANNEL ----------------------------
    private val methodChannelName = "zep/methods/$handlerName"
    private var methodChannel: MethodChannel? = null

    private fun setupMethodChannel(messenger: BinaryMessenger) {
        methodChannel = MethodChannel(messenger, methodChannelName)
        methodChannel?.setMethodCallHandler(this)
    }

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method){
            "getSupportedScanners" -> result.success(getSupportedScanners(false))
            "getConnectedScanners" -> result.success(getSupportedScanners(true))
            "initScanner" -> {
                val friendlyName = methodCall.arguments as? String
                if (friendlyName == null) {
                    result.error("INVALID_ARGS", "Expected a String argument (friendlyName)", null)
                    return
                }
                result.success(initScanner(friendlyName))
            }
            "deinitScanner" -> result.success(deinitScanner())
            "getScannerInfo" -> result.success(getScannerInfo())
            "enableRead" -> result.success(enableRead())
            "disableRead" -> result.success(disableRead())
            "getConfig" -> result.success(getConfig())
            "setConfig" -> {
                @Suppress("UNCHECKED_CAST")
                val configMap = methodCall.arguments as? Map<String, Any?>
                if (configMap == null) {
                    result.error("INVALID_ARGS", "Expected a Map argument (config)", null)
                    return
                }
                result.success(setConfig(configMap))
            }

        }
    }
    // -----------------------------------------------------------------------

    // ---------------------------- EVENT CHANNEL ----------------------------
    private val eventChannelName = "zep/events/$handlerName"
    private var eventChannel: EventChannel? = null
    private var eventSink: EventSink? = null

    private fun setupEventChannel(messenger: BinaryMessenger) {
        eventChannel = EventChannel(messenger, eventChannelName)
        eventChannel?.setStreamHandler(this)
    }

    override fun onListen(arguments: Any?, events: EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
    // -----------------------------------------------------------------------
    private var currentScanner: Scanner? = null

    override fun onConnectionChange(scannerInfo: ScannerInfo?, connectionState: ConnectionState?) {
        if(eventSink == null) return

        eventSink!!.sendEvent(
            "onConnectionChange",
            mapOf(
                "scannerInfo" to scannerInfo?.toMap(),
                "connectionState" to connectionState?.name,
            )
        )
    }

    private fun getSupportedScanners(onlyConnected: Boolean): Map<String, Any?> {
        val devicesList = barcodeManager.supportedDevicesInfo
            ?.filter { data -> !onlyConnected || data.isConnected }
            ?.map { data -> data.toMap() } ?: emptyList()

        return mapOf("devicesList" to devicesList)
    }

    private fun initScanner(friendlyName: String): Boolean {
        if(currentScanner != null) deinitScanner()

        val scannerInfo = barcodeManager.supportedDevicesInfo
            ?.firstOrNull { it.friendlyName.equals(friendlyName, ignoreCase = true) }
            ?: return false

        if(!scannerInfo.isConnected) return false

        currentScanner = barcodeManager.getDevice(scannerInfo)

        if(currentScanner != null){
            try{
                currentScanner!!.addDataListener(this)
                currentScanner!!.addStatusListener(this)
                currentScanner!!.enable()
            }
            catch (error: ScannerException){
                deinitScanner()
                return false
            }

            return true
        }

        return false
    }

    private fun deinitScanner(): Boolean {
        if(currentScanner == null) return false

        try{
            currentScanner!!.disable()
            currentScanner!!.removeDataListener(this)
            currentScanner!!.removeStatusListener(this)
            currentScanner!!.release()
        }
        catch (error: ScannerException){

        }
        finally{
            currentScanner = null
        }

        return true
    }

    private fun getScannerInfo(): Map<String, Any?>? {
        if(currentScanner == null) return null

        return currentScanner!!.scannerInfo?.toMap()
    }

    private fun enableRead(): Boolean {
        if(currentScanner == null) return false

        if (!currentScanner!!.isEnabled) return false
        if (currentScanner!!.isReadPending) return false

        currentScanner!!.read()

        return true
    }

    private fun disableRead(): Boolean {
        if(currentScanner == null) return false

        if (!currentScanner!!.isEnabled) return false

        currentScanner!!.cancelRead()

        return true
    }

    private fun getConfig(): Map<String, Any?>? {
        if(currentScanner == null) return null

        return extractConfigToMap(currentScanner!!.config)
    }

    private fun setConfig(configMap: Map<String, Any?>): Boolean {
        if(currentScanner == null) return false
        val config = currentScanner!!.config

        applyMapToConfig(configMap, config)
        currentScanner!!.config = config

        return true
    }

    override fun onStatus(statusData: StatusData?) {
        if(eventSink == null) return

        eventSink!!.sendEvent(
            "onStatus",
            statusData?.toMap() ?: emptyMap()
        )
    }

    override fun onData(scanDataCollection: ScanDataCollection?) {
        if(eventSink == null) return

        eventSink!!.sendEvent(
            "onData",
            scanDataCollection?.toMap() ?: emptyMap()
        )
    }

    private fun extractConfigToMap(obj: Any): Map<String, Any?> {
        val map = mutableMapOf<String, Any?>()
        val clazz = obj::class.java

        for (field in clazz.fields) {
            try {
                val value = field.get(obj)
                when {
                    value == null -> map[field.name] = null
                    field.type.isEnum -> map[field.name] = (value as Enum<*>).name
                    value is String || value is Int || value is Boolean || value is Double || value is Float || value is Long -> map[field.name] = value
                    value.javaClass.name.startsWith("com.symbol.emdk") -> map[field.name] = extractConfigToMap(value)
                }
            } catch (e: Exception) { }
        }
        return map
    }

    @Suppress("UNCHECKED_CAST")
    private fun applyMapToConfig(map: Map<String, Any?>, target: Any) {
        val clazz = target::class.java

        for ((key, value) in map) {
            if (value == null) continue
            try {
                val field = clazz.getField(key)

                when {
                    value is Map<*, *> -> {
                        val subObj = field.get(target)
                        if (subObj != null) applyMapToConfig(value as Map<String, Any?>, subObj)
                    }
                    field.type.isEnum -> {
                        val enumConstants = field.type.enumConstants ?: continue
                        for (enumConstant in enumConstants) {
                            if ((enumConstant as Enum<*>).name == value.toString()) {
                                field.set(target, enumConstant)
                                break
                            }
                        }
                    }
                    field.type == Int::class.java || field.type == Integer.TYPE -> field.set(target, (value as Number).toInt())
                    field.type == Boolean::class.java || field.type == java.lang.Boolean.TYPE -> field.set(target, value as Boolean)
                    field.type == Float::class.java || field.type == java.lang.Float.TYPE -> field.set(target, (value as Number).toFloat())
                    field.type == Double::class.java || field.type == java.lang.Double.TYPE -> field.set(target, (value as Number).toDouble())
                    field.type == Long::class.java || field.type == java.lang.Long.TYPE -> field.set(target, (value as Number).toLong())
                    field.type == String::class.java -> field.set(target, value.toString())
                    else -> field.set(target, value)
                }
            } catch (e: NoSuchFieldException) { } catch (e: Exception) { }
        }
    }
}