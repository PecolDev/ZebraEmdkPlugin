package dev.pecol.zebra_emdk_plugin

import android.content.Context
import android.content.pm.PackageManager
import android.database.Cursor
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.Base64
import android.util.Log
import androidx.core.net.toUri
import com.symbol.emdk.EMDKManager
import com.symbol.emdk.EMDKManager.EMDKListener
import com.symbol.emdk.ProfileManager
import com.symbol.emdk.barcode.BarcodeManager
import com.symbol.emdk.barcode.BarcodeManager.ConnectionState
import com.symbol.emdk.barcode.BarcodeManager.ScannerConnectionListener
import com.symbol.emdk.barcode.ScanDataCollection
import com.symbol.emdk.barcode.Scanner
import com.symbol.emdk.barcode.Scanner.StatusListener
import com.symbol.emdk.barcode.ScannerException
import com.symbol.emdk.barcode.ScannerInfo
import com.symbol.emdk.barcode.StatusData
import com.symbol.emdk.notification.Notification
import com.symbol.emdk.notification.Notification.Beep
import com.symbol.emdk.notification.Notification.BeepParams
import com.symbol.emdk.notification.Notification.LEDParams
import com.symbol.emdk.notification.Notification.VibrateParams
import com.symbol.emdk.notification.NotificationDevice
import com.symbol.emdk.notification.NotificationManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class ZebraEmdkPlugin : FlutterPlugin, MethodCallHandler, EMDKListener, ScannerConnectionListener, StatusListener, Scanner.DataListener, ProfileManager.DataListener {

    companion object {
        private const val TAG = "ZebraEmdkPlugin"
    }

    private var applicationContext: Context? = null
    private var emdkManager: EMDKManager? = null
    private var scanner: Scanner? = null
    private var notificationDevice: NotificationDevice? = null
    private var profileManager: ProfileManager? = null

    // Unified Method Channel
    private val unifiedMethodChannelName = "zebra_emdk_plugin/methods"
    private var unifiedMethodChannel: MethodChannel? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = flutterPluginBinding.applicationContext
        val messenger = flutterPluginBinding.binaryMessenger

        setupUnifiedMethodChannel(messenger)
        setupEmdkManagerEventChannel(messenger)
        setupBarcodeManagerEventChannel(messenger)
        setupScannerEventChannel(messenger)
        setupProfileManagerEventChannel(messenger)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        unifiedMethodChannel?.setMethodCallHandler(null)
        emdkManagerEventChannel?.setStreamHandler(null)
        barcodeManagerEventChannel?.setStreamHandler(null)
        scannerEventChannel?.setStreamHandler(null)
        profileManagerEventChannel?.setStreamHandler(null)

        // Dispose resources in dependency order before releasing the EMDK manager
        safeDisposeScanner()
        safeDisposeNotificationDevice()

        emdkManager?.release()
        emdkManager = null
        applicationContext = null
    }

    private fun setupUnifiedMethodChannel(messenger: BinaryMessenger) {
        unifiedMethodChannel = MethodChannel(messenger, unifiedMethodChannelName)
        unifiedMethodChannel?.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {

            // emdkManager Prefix
            "emdkManager#initialize" -> {
                val ctx = applicationContext
                if (ctx == null) {
                    result.error("NO_CONTEXT", "Application context is not available", null)
                    return
                }
                result.success(initEMDKManager(ctx))
            }

            // barcodeManager Prefix
            "barcodeManager#initialize" -> result.success(initBarcodeManager())
            "barcodeManager#dispose" -> result.success(disposeBarcodeManager())
            "barcodeManager#getSupportedScanners" -> result.success(getSupportedScanners())
            "barcodeManager#setScannerTypeByFriendlyName" -> {
                val friendlyName = call.arguments as? String
                if (friendlyName == null) {
                    result.error("INVALID_ARGS", "Expected a String argument (friendlyName)", null)
                    return
                }
                result.success(setScannerTypeByFriendlyName(friendlyName))
            }

            // scanner Prefix
            "scanner#initialize" -> result.success(initializeScanner())
            "scanner#dispose" -> result.success(disposeScanner())
            "scanner#getScannerInfo" -> result.success(getScannerInfo())
            "scanner#getConfig" -> result.success(getConfig())
            "scanner#setConfig" -> {
                @Suppress("UNCHECKED_CAST")
                val configMap = call.arguments as? Map<String, Any?>
                if (configMap == null) {
                    result.error("INVALID_ARGS", "Expected a Map argument (config)", null)
                    return
                }
                result.success(setConfig(configMap))
            }
            "scanner#enableRead" -> result.success(enableRead())
            "scanner#disableRead" -> result.success(disableRead())

            // notificationManager Prefix
            "notificationManager#initialize" -> result.success(initNotificationManager())
            "notificationManager#getSupportedDevices" -> result.success(getSupportedNotificationDevices())
            "notificationManager#setNotificationDeviceByFriendlyName" -> {
                val friendlyName = call.arguments as? String
                if (friendlyName == null) {
                    result.error("INVALID_ARGS", "Expected a String argument (friendlyName)", null)
                    return
                }
                result.success(setNotificationDeviceByFriendlyName(friendlyName))
            }

            // notificationDevice Prefix
            "notificationDevice#initialize" -> result.success(initializeNotificationDevice())
            "notificationDevice#dispose" -> result.success(disposeNotificationDevice())
            "notificationDevice#getNotificationDeviceInfo" -> result.success(getNotificationDeviceInfo())
            "notificationDevice#notify" -> {
                @Suppress("UNCHECKED_CAST")
                val commandMap = call.arguments as? Map<String, Any?>
                if (commandMap == null) {
                    result.error("INVALID_ARGS", "Expected a Map argument (command)", null)
                    return
                }
                result.success(triggerNotification(commandMap))
            }

            // profileManager Prefix
            "profileManager#initialize" -> result.success(initProfileManager())
            "profileManager#processProfile" -> {
                @Suppress("UNCHECKED_CAST")
                val args = call.arguments as? Map<String, Any?>
                val profileName = args?.get("profileName") as? String
                val xmlData = args?.get("xmlData") as? String
                if (profileName == null || xmlData == null) {
                    result.error("INVALID_ARGS", "profileName and xmlData must be non-null strings", null)
                    return
                }
                processProfile(profileName, xmlData)
                result.success(null)  // reply immediately; async result comes via profileManagerEventChannel
            }

            // oemInfo Prefix
            "oemInfo#getBluetoothMac" -> result.success(getBluetoothMac())
            "oemInfo#getSerialNumber" -> result.success(getSerialNumber())
            "oemInfo#getProductModel" -> result.success(getProductModel())
            "oemInfo#getWifiMac" -> result.success(getWifiMac())
            "oemInfo#getPeripheralBatteryInfo" -> result.success(getPeripheralBatteryInfo())
            "oemInfo#getPeripheralDeviceInfo" -> result.success(getPeripheralDeviceInfo())

            else -> result.notImplemented()
        }
    }

    /**
     * Sends a typed event on a sink. Captures [this] sink reference in the lambda so it remains
     * valid even if the field is set to null on another thread between the call-site null-check
     * and the main-thread post.
     */
    private fun EventChannel.EventSink.sendEvent(type: String, payload: Map<String, Any?> = emptyMap()) {
        val event = mapOf(
            "type" to type,
            "payload" to payload,
            "timestamp" to System.currentTimeMillis()
        )
        Handler(Looper.getMainLooper()).post {
            success(event)
        }
    }

    // ****************************** EMDK Manager ******************************
    private val emdkManagerEventChannelName = "emdk_manager_event_channel"
    private var emdkManagerEventChannel: EventChannel? = null
    // @Volatile ensures visibility of writes across threads (EMDK callbacks run on background threads)
    @Volatile private var emdkManagerEventSink: EventChannel.EventSink? = null

    private fun setupEmdkManagerEventChannel(messenger: BinaryMessenger) {
        emdkManagerEventChannel = EventChannel(messenger, emdkManagerEventChannelName)
        emdkManagerEventChannel?.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                emdkManagerEventSink = events
            }
            override fun onCancel(arguments: Any?) {
                emdkManagerEventSink = null
            }
        })
    }

    private fun initEMDKManager(context: Context): String {
        val results = EMDKManager.getEMDKManager(context, this)
        return results.statusCode.name
    }

    override fun onOpened(emdkManager: EMDKManager?) {
        this.emdkManager = emdkManager
        emdkManagerEventSink?.sendEvent("onOpened")
    }

    override fun onClosed() {
        emdkManager?.release()
        emdkManager = null
        emdkManagerEventSink?.sendEvent("onClosed")
    }
    // **************************************************************************

    // ****************************** Barcode Manager ******************************
    private val barcodeManagerEventChannelName = "barcode_manager_event_channel"
    private var barcodeManagerEventChannel: EventChannel? = null
    @Volatile private var barcodeManagerEventSink: EventChannel.EventSink? = null

    private var barcodeManager: BarcodeManager? = null

    private fun setupBarcodeManagerEventChannel(messenger: BinaryMessenger) {
        barcodeManagerEventChannel = EventChannel(messenger, barcodeManagerEventChannelName)
        barcodeManagerEventChannel?.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                barcodeManagerEventSink = events
            }
            override fun onCancel(arguments: Any?) {
                barcodeManagerEventSink = null
            }
        })
    }

    private fun initBarcodeManager(): Boolean {
        // Capture local reference to guard against concurrent null assignment
        val emdk = emdkManager
        if (emdk == null) {
            Log.e(TAG, "initBarcodeManager() called but EMDKManager is not initialized")
            return false
        }
        barcodeManager = emdk.getInstance(EMDKManager.FEATURE_TYPE.BARCODE) as? BarcodeManager
        if (barcodeManager == null) {
            Log.e(TAG, "initBarcodeManager() BarcodeManager feature is not available on this device")
            return false
        }
        barcodeManager!!.addConnectionListener(this)
        return true
    }

    private fun disposeBarcodeManager(): Boolean {
        barcodeManager?.removeConnectionListener(this)
        barcodeManager = null
        return true
    }

    private fun getSupportedScanners(): Map<String, Any?> {
        val devicesList = barcodeManager?.supportedDevicesInfo?.map { data ->
            mapOf(
                "connectionType" to data.connectionType.name,
                "decoderType" to data.decoderType.name,
                "deviceIdentifier" to data.deviceIdentifier.name,
                "deviceType" to data.deviceType.name,
                "friendlyName" to data.friendlyName,
                "modelNumber" to data.modelNumber,
                "isConnected" to data.isConnected,
                "isDefaultScanner" to data.isDefaultScanner
            )
        }
        return mapOf("devicesList" to devicesList)
    }

    private fun setScannerTypeByFriendlyName(friendlyName: String): Boolean {
        val scannerInfo = barcodeManager
            ?.supportedDevicesInfo
            ?.firstOrNull { it.friendlyName.equals(friendlyName, ignoreCase = true) }
            ?: return false

        scanner = barcodeManager?.getDevice(scannerInfo)
        return scanner != null
    }

    override fun onConnectionChange(scannerInfo: ScannerInfo?, connectionState: ConnectionState?) {
        // Capture sink locally to avoid race between null-check and post
        val sink = barcodeManagerEventSink ?: return
        sink.sendEvent(
            "onConnectionChange",
            mapOf(
                "scannerInfo" to mapOf(
                    "connectionType" to scannerInfo?.connectionType?.name,
                    "decoderType" to scannerInfo?.decoderType?.name,
                    "deviceIdentifier" to scannerInfo?.deviceIdentifier?.name,
                    "deviceType" to scannerInfo?.deviceType?.name,
                    "friendlyName" to scannerInfo?.friendlyName,
                    "isConnected" to scannerInfo?.isConnected,
                    "isDefaultScanner" to scannerInfo?.isDefaultScanner,
                    "modelNumber" to scannerInfo?.modelNumber
                ),
                "connectionState" to connectionState?.name,
            )
        )
    }
    // **************************************************************************

    // ****************************** Scanner ******************************
    private val scannerEventChannelName = "scanner_event_channel"
    private var scannerEventChannel: EventChannel? = null
    @Volatile private var scannerEventSink: EventChannel.EventSink? = null

    private fun setupScannerEventChannel(messenger: BinaryMessenger) {
        scannerEventChannel = EventChannel(messenger, scannerEventChannelName)
        scannerEventChannel?.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                scannerEventSink = events
            }
            override fun onCancel(arguments: Any?) {
                scannerEventSink = null
            }
        })
    }

    private fun initializeScanner(): Boolean {
        val sc = scanner ?: return false
        return try {
            sc.addDataListener(this)
            sc.addStatusListener(this)
            sc.enable()
            // triggerType must be set after enable() on some Zebra devices
            sc.triggerType = Scanner.TriggerType.HARD
            true
        } catch (e: ScannerException) {
            Log.e(TAG, "initializeScanner() ScannerException: ${e.message}", e)
            safeDisposeScanner()
            false
        } catch (e: Exception) {
            Log.e(TAG, "initializeScanner() unexpected exception: ${e.message}", e)
            safeDisposeScanner()
            false
        }
    }

    private fun disposeScanner(): Boolean {
        safeDisposeScanner()
        return true
    }

    /** Safely releases the scanner, logging any errors. Always nulls out [scanner]. */
    private fun safeDisposeScanner() {
        val sc = scanner ?: return
        try {
            sc.release()
        } catch (e: ScannerException) {
            Log.w(TAG, "safeDisposeScanner() ScannerException during release: ${e.message}")
        } catch (e: Exception) {
            Log.w(TAG, "safeDisposeScanner() unexpected exception during release: ${e.message}")
        } finally {
            scanner = null
        }
    }

    private fun getScannerInfo(): Map<String, Any?>? {
        val sc = scanner ?: return null
        return mapOf(
            "connectionType" to sc.scannerInfo?.connectionType?.name,
            "decoderType" to sc.scannerInfo?.decoderType?.name,
            "deviceIdentifier" to sc.scannerInfo?.deviceIdentifier?.name,
            "deviceType" to sc.scannerInfo?.deviceType?.name,
            "friendlyName" to sc.scannerInfo?.friendlyName,
            "modelNumber" to sc.scannerInfo?.modelNumber,
            "isConnected" to sc.scannerInfo?.isConnected,
            "isDefaultScanner" to sc.scannerInfo?.isDefaultScanner
        )
    }

    private fun enableRead(): Boolean {
        val sc = scanner ?: return false
        if (!sc.isEnabled) return false
        if (sc.isReadPending) return false
        return try {
            sc.read()
            true
        } catch (e: ScannerException) {
            Log.e(TAG, "enableRead() ScannerException: ${e.message}")
            false
        } catch (e: Exception) {
            Log.e(TAG, "enableRead() unexpected exception: ${e.message}")
            false
        }
    }

    private fun disableRead(): Boolean {
        val sc = scanner ?: return false
        return try {
            sc.cancelRead()
            true
        } catch (e: ScannerException) {
            Log.e(TAG, "disableRead() ScannerException: ${e.message}")
            false
        } catch (e: Exception) {
            Log.e(TAG, "disableRead() unexpected exception: ${e.message}")
            false
        }
    }

    private fun getConfig(): Map<String, Any?>? {
        val config = scanner?.config ?: return null
        return extractConfigToMap(config)
    }

    private fun setConfig(configMap: Map<String, Any?>): Boolean {
        val config = scanner?.config ?: return false
        return try {
            applyMapToConfig(configMap, config)
            scanner?.config = config
            true
        } catch (e: Exception) {
            Log.e(TAG, "setConfig() exception: ${e.message}", e)
            false
        }
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
            } catch (e: Exception) {
                Log.w(TAG, "extractConfigToMap() skipping field '${field.name}': ${e.message}")
            }
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
            } catch (e: NoSuchFieldException) {
                // Silently ignore unknown fields sent from the Dart side
            } catch (e: Exception) {
                Log.w(TAG, "applyMapToConfig() failed for key '$key': ${e.message}")
            }
        }
    }

    override fun onStatus(statusData: StatusData?) {
        val sink = scannerEventSink ?: return
        sink.sendEvent(
            "onStatus",
            mapOf(
                "friendlyName" to statusData?.friendlyName,
                "state" to statusData?.state?.name,
            )
        )
    }

    override fun onData(scanDataCollection: ScanDataCollection?) {
        val sink = scannerEventSink ?: return

        val scanDataList = scanDataCollection?.scanData?.map { data ->
            mapOf(
                "data" to data.data,
                "labelType" to data.labelType.name,
                "rawData" to data.rawData,
                "timeStamp" to data.timeStamp
            )
        }

        val tokensList = scanDataCollection?.tokenizedData?.tokens?.map { token ->
            mapOf(
                "data" to token.data,
                "dataType" to token.dataType,
                "format" to token.format,
                "key" to token.key,
                "rawData" to token.rawData
            )
        }

        val tokenizedDataMap = scanDataCollection?.tokenizedData?.let {
            mapOf("tokens" to (tokensList ?: emptyList<Map<String, Any?>>()))
        }

        sink.sendEvent(
            "onData",
            mapOf(
                "friendlyName" to scanDataCollection?.friendlyName,
                "labelIdentifier" to scanDataCollection?.labelIdentifier,
                "scannerResult" to scanDataCollection?.result?.name,
                "scanData" to scanDataList,
                "tokenizedData" to tokenizedDataMap
            )
        )
    }
    // **************************************************************************

    // ****************************** Notification Manager ******************************
    private var notificationManager: NotificationManager? = null

    private fun initNotificationManager(): Boolean {
        val emdk = emdkManager
        if (emdk == null) {
            Log.e(TAG, "initNotificationManager() called but EMDKManager is not initialized")
            return false
        }
        notificationManager = emdk.getInstance(EMDKManager.FEATURE_TYPE.NOTIFICATION) as? NotificationManager
        if (notificationManager == null) {
            Log.e(TAG, "initNotificationManager() NotificationManager feature is not available on this device")
            return false
        }
        return true
    }

    private fun getSupportedNotificationDevices(): List<Map<String, Any?>> {
        val devices = notificationManager?.supportedDevicesInfo ?: return emptyList()

        return devices.map { info ->
            mapOf(
                "friendlyName" to info.friendlyName,
                "modelNumber" to info.modelNumber,
                "deviceType" to info.deviceType?.name,
                "connectionType" to info.connectionType?.name,
                "deviceIdentifier" to info.deviceIdentifier?.name,
                "isDefaultDevice" to info.isDefaultDevice,
                "isConnected" to info.isConnected,
                "isLEDSupported" to info.isLEDSupported,
                "isBeepSupported" to info.isBeepSupported,
                "isVibrateSupported" to info.isVibrateSupported
            )
        }
    }

    private fun setNotificationDeviceByFriendlyName(friendlyName: String): Boolean {
        val device = notificationManager
            ?.supportedDevicesInfo
            ?.firstOrNull { it.friendlyName.equals(friendlyName, ignoreCase = true) }
            ?: return false

        notificationDevice = notificationManager?.getDevice(device)
        return notificationDevice != null
    }
    // **************************************************************************

    // ****************************** Notification Device ******************************
    private fun initializeNotificationDevice(): Boolean {
        val nd = notificationDevice ?: return false
        return try {
            nd.enable()
            true
        } catch (e: Exception) {
            Log.e(TAG, "initializeNotificationDevice() exception: ${e.message}", e)
            safeDisposeNotificationDevice()
            false
        }
    }

    private fun disposeNotificationDevice(): Boolean {
        safeDisposeNotificationDevice()
        return true
    }

    /** Safely disables the notification device, logging any errors. Always nulls out [notificationDevice]. */
    private fun safeDisposeNotificationDevice() {
        val nd = notificationDevice ?: return
        try {
            nd.disable()
        } catch (e: Exception) {
            Log.w(TAG, "safeDisposeNotificationDevice() exception during disable: ${e.message}")
        } finally {
            notificationDevice = null
        }
    }

    private fun getNotificationDeviceInfo(): Map<String, Any?>? {
        val nd = notificationDevice ?: return null
        return mapOf(
            "friendlyName" to nd.deviceInfo?.friendlyName,
            "modelNumber" to nd.deviceInfo?.modelNumber,
            "deviceType" to nd.deviceInfo?.deviceType?.name,
            "connectionType" to nd.deviceInfo?.connectionType?.name,
            "deviceIdentifier" to nd.deviceInfo?.deviceIdentifier?.name,
            "isDefaultDevice" to nd.deviceInfo?.isDefaultDevice,
            "isConnected" to nd.deviceInfo?.isConnected,
            "isLEDSupported" to nd.deviceInfo?.isLEDSupported,
            "isBeepSupported" to nd.deviceInfo?.isBeepSupported,
            "isVibrateSupported" to nd.deviceInfo?.isVibrateSupported
        )
    }

    private fun triggerNotification(commandMap: Map<String, Any?>): Boolean {
        val nd = notificationDevice ?: return false

        return try {
            val notification = Notification()

            val ledMap = commandMap["led"] as? Map<String, Any?>
            if (ledMap != null) {
                val led = LEDParams()
                led.color = (ledMap["color"] as? Number)?.toInt() ?: 0
                led.onTime = (ledMap["onTime"] as? Number)?.toInt() ?: 0
                led.offTime = (ledMap["offTime"] as? Number)?.toInt() ?: 0
                led.repeatCount = (ledMap["repeatCount"] as? Number)?.toInt() ?: 0
                notification.led = led
            }

            val beepMap = commandMap["beep"] as? Map<String, Any?>
            if (beepMap != null) {
                val beepParams = BeepParams()
                @Suppress("UNCHECKED_CAST")
                val patternList = beepMap["pattern"] as? List<Map<String, Any?>>
                if (patternList != null) {
                    beepParams.pattern = Array(patternList.size) { i ->
                        val pMap = patternList[i]
                        Beep().also {
                            it.time = (pMap["time"] as? Number)?.toInt() ?: 0
                            it.frequency = (pMap["frequency"] as? Number)?.toInt() ?: 0
                        }
                    }
                }
                notification.beep = beepParams
            }

            val vibrateMap = commandMap["vibrate"] as? Map<String, Any?>
            if (vibrateMap != null) {
                val vibrate = VibrateParams()
                vibrate.time = (vibrateMap["time"] as? Number)?.toLong() ?: 0
                @Suppress("UNCHECKED_CAST")
                val patList = vibrateMap["pattern"] as? List<Number>
                if (patList != null) {
                    vibrate.pattern = LongArray(patList.size) { i -> patList[i].toLong() }
                }
                notification.vibrate = vibrate
            }

            nd.notify(notification)
            true
        } catch (e: Exception) {
            Log.e(TAG, "triggerNotification() exception: ${e.message}", e)
            false
        }
    }
    // **************************************************************************

    // ****************************** Profile Manager ******************************
    private val profileManagerEventChannelName = "profile_manager_event_channel"
    private var profileManagerEventChannel: EventChannel? = null
    @Volatile private var profileManagerEventSink: EventChannel.EventSink? = null

    private fun setupProfileManagerEventChannel(messenger: BinaryMessenger) {
        profileManagerEventChannel = EventChannel(messenger, profileManagerEventChannelName)
        profileManagerEventChannel?.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                profileManagerEventSink = events
            }
            override fun onCancel(arguments: Any?) {
                profileManagerEventSink = null
            }
        })
    }

    private fun initProfileManager(): Boolean {
        val emdk = emdkManager
        if (emdk == null) {
            Log.e(TAG, "initProfileManager() called but EMDKManager is not initialized")
            return false
        }
        profileManager = emdk.getInstance(EMDKManager.FEATURE_TYPE.PROFILE) as? ProfileManager
        if (profileManager == null) {
            Log.e(TAG, "initProfileManager() ProfileManager feature is not available on this device")
            return false
        }
        profileManager!!.addDataListener(this)
        applyProfiles()
        return true
    }

    override fun onData(resultData: ProfileManager.ResultData?) {
        val sink = profileManagerEventSink ?: return

        val profileName = resultData?.profileName
        val statusCode = resultData?.result?.statusCode?.name
        val extendedStatusCode = resultData?.result?.extendedStatusCode?.name

        // Prominently log profile failures so they appear clearly in logcat
        if (statusCode != null && statusCode != "SUCCESS") {
            Log.e(TAG, "Profile '$profileName' FAILED — statusCode=$statusCode, extendedStatusCode=$extendedStatusCode, detail=${resultData?.result?.statusString}")
        } else {
            Log.d(TAG, "Profile '$profileName' applied successfully.")
        }

        sink.sendEvent(
            "onData",
            mapOf(
                "result" to mapOf(
                    "statusCode" to statusCode,
                    "extendedStatusCode" to extendedStatusCode,
                    "statusString" to resultData?.result?.statusString
                ),
                "profileName" to profileName,
                "profileFlag" to resultData?.profileFlag?.name,
                "profileString" to resultData?.profileString
            )
        )
    }

    private fun processProfile(profileName: String, xmlData: String) {
        val pm = profileManager
        if (pm == null) {
            Log.w(TAG, "processProfile('$profileName') called but ProfileManager is null — ignoring")
            return
        }
        pm.processProfileAsync(profileName, ProfileManager.PROFILE_FLAG.SET, arrayOf(xmlData))
    }

    private fun applyProfiles() {
        val appSignature = getAppSignature()
        val packageName = applicationContext?.packageName ?: ""

        processProfile("AccessMgrProfile", "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
                "<characteristic type=\"Profile\">" +
                "<parm name=\"ProfileName\" value=\"AccessMgrProfile\"/>" +

                "<characteristic type=\"AccessMgr\">" +
                "<parm name=\"OperationMode\" value=\"1\"/>" +
                "<parm name=\"ServiceAccessAction\" value=\"4\" />" +
                "<parm name=\"ServiceIdentifier\" value=\"content://oem_info/oem.zebra.secure/bt_mac\" />" +
                "<parm name=\"CallerPackageName\" value=\"$packageName\" />" +
                "<parm name=\"CallerSignature\" value=\"$appSignature\" />" +
                "</characteristic>" +

                "<characteristic type=\"AccessMgr\">" +
                "<parm name=\"OperationMode\" value=\"1\"/>" +
                "<parm name=\"ServiceAccessAction\" value=\"4\" />" +
                "<parm name=\"ServiceIdentifier\" value=\"content://oem_info/oem.zebra.secure/build_serial\" />" +
                "<parm name=\"CallerPackageName\" value=\"$packageName\" />" +
                "<parm name=\"CallerSignature\" value=\"$appSignature\" />" +
                "</characteristic>" +

                "<characteristic type=\"AccessMgr\">" +
                "<parm name=\"OperationMode\" value=\"1\"/>" +
                "<parm name=\"ServiceAccessAction\" value=\"4\" />" +
                "<parm name=\"ServiceIdentifier\" value=\"content://oem_info/oem.zebra.secure/ro_product_model\" />" +
                "<parm name=\"CallerPackageName\" value=\"$packageName\" />" +
                "<parm name=\"CallerSignature\" value=\"$appSignature\" />" +
                "</characteristic>" +

                "<characteristic type=\"AccessMgr\">" +
                "<parm name=\"OperationMode\" value=\"1\"/>" +
                "<parm name=\"ServiceAccessAction\" value=\"4\" />" +
                "<parm name=\"ServiceIdentifier\" value=\"content://oem_info/oem.zebra.secure/wifi_mac\" />" +
                "<parm name=\"CallerPackageName\" value=\"$packageName\" />" +
                "<parm name=\"CallerSignature\" value=\"$appSignature\" />" +
                "</characteristic>" +

                "<characteristic type=\"AccessMgr\">" +
                "<parm name=\"OperationMode\" value=\"1\"/>" +
                "<parm name=\"ServiceAccessAction\" value=\"4\" />" +
                "<parm name=\"ServiceIdentifier\" value=\"content://com.symbol.devicecentral.provider/peripheral_info/battery_info\" />" +
                "<parm name=\"CallerPackageName\" value=\"$packageName\" />" +
                "<parm name=\"CallerSignature\" value=\"$appSignature\" />" +
                "</characteristic>" +

                "<characteristic type=\"AccessMgr\">" +
                "<parm name=\"OperationMode\" value=\"1\"/>" +
                "<parm name=\"ServiceAccessAction\" value=\"4\" />" +
                "<parm name=\"ServiceIdentifier\" value=\"content://com.symbol.devicecentral.provider/peripheral_info/device_info\" />" +
                "<parm name=\"CallerPackageName\" value=\"$packageName\" />" +
                "<parm name=\"CallerSignature\" value=\"$appSignature\" />" +
                "</characteristic>" +

                "</characteristic>")
    }
    // **************************************************************************

    // ****************************** Oem Info ******************************
    private fun getAppSignature(): String? {
        val context = applicationContext ?: return null
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.P) return null

        return try {
            val packageInfo = context.packageManager.getPackageInfo(
                context.packageName,
                PackageManager.GET_SIGNING_CERTIFICATES
            )
            if (packageInfo.signingInfo == null) return null
            val cert = packageInfo.signingInfo!!.apkContentsSigners[0].toByteArray()
            Base64.encodeToString(cert, Base64.NO_WRAP)
        } catch (e: Exception) {
            Log.w(TAG, "getAppSignature() exception: ${e.message}")
            null
        }
    }

    private fun getBluetoothMac(): String? = resolveCursorUri("content://oem_info/oem.zebra.secure/bt_mac")
    private fun getSerialNumber(): String? = resolveCursorUri("content://oem_info/oem.zebra.secure/build_serial")
    private fun getProductModel(): String? = resolveCursorUri("content://oem_info/oem.zebra.secure/ro_product_model")
    private fun getWifiMac(): String? = resolveCursorUri("content://oem_info/oem.zebra.secure/wifi_mac")
    private fun getPeripheralBatteryInfo(): String? = resolveCursorUriToMap("content://com.symbol.devicecentral.provider/peripheral_info/battery_info")
    private fun getPeripheralDeviceInfo(): String? = resolveCursorUriToMap("content://com.symbol.devicecentral.provider/peripheral_info/device_info")

    /**
     * For simple single-value URIs (e.g. oem_info) that return a single string in column 0.
     */
    private fun resolveCursorUri(uriTarget: String): String? {
        val uri = uriTarget.toUri()
        val context = applicationContext ?: return null
        var cursor: Cursor? = null
        return try {
            cursor = context.contentResolver.query(uri, null, null, null, null)
            if (cursor != null && cursor.moveToFirst() && cursor.columnCount > 0) cursor.getString(0) else null
        } catch (e: Exception) {
            Log.w(TAG, "resolveCursorUri() failed for '$uriTarget': ${e.message}")
            null
        } finally {
            cursor?.close()
        }
    }

    /**
     * For multi-column URIs (e.g. Device Central peripheral_info) that may return several named
     * columns per row. Reads every column by name and returns a JSON object string, e.g.:
     *   {"serialNumber":"12345","modelNumber":"RS5100", ...}
     * Returns null if the cursor is empty or the query fails.
     */
    private fun resolveCursorUriToMap(uriTarget: String): String? {
        val uri = uriTarget.toUri()
        val context = applicationContext ?: return null
        var cursor: Cursor? = null
        return try {
            cursor = context.contentResolver.query(uri, null, null, null, null)
            if (cursor == null || !cursor.moveToFirst()) return null

            val columns = cursor.columnNames
            if (columns.isEmpty()) {
                Log.w(TAG, "resolveCursorUriToMap() cursor for '$uriTarget' has no columns")
                return null
            }

            val sb = StringBuilder("{")
            columns.forEachIndexed { index, colName ->
                val value = try { cursor.getString(index) } catch (e: Exception) { null }
                if (index > 0) sb.append(",")
                // Simple JSON serialization — escape backslash and double-quote in value
                val safe = value?.replace("\\", "\\\\")?.replace("\"", "\\\"") ?: ""
                sb.append("\"$colName\":\"$safe\"")
            }
            sb.append("}")
            sb.toString()
        } catch (e: Exception) {
            Log.w(TAG, "resolveCursorUriToMap() failed for '$uriTarget': ${e.message}")
            null
        } finally {
            cursor?.close()
        }
    }
}
