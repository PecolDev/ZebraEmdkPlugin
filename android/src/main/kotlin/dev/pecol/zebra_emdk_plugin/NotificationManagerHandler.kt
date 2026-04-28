package dev.pecol.zebra_emdk_plugin

import com.symbol.emdk.notification.Notification
import com.symbol.emdk.notification.Notification.Beep
import com.symbol.emdk.notification.Notification.BeepParams
import com.symbol.emdk.notification.Notification.LEDParams
import com.symbol.emdk.notification.Notification.VibrateParams
import com.symbol.emdk.notification.NotificationDevice
import com.symbol.emdk.notification.NotificationException
import com.symbol.emdk.notification.NotificationManager
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class NotificationManagerHandler : EventChannel.StreamHandler, MethodCallHandler {
    private val handlerName: String = "notification_manager"
    private lateinit var notificationManager: NotificationManager

    fun setupChannels(messenger: BinaryMessenger){
        setupMethodChannel(messenger)
        setupEventChannel(messenger)
    }

    fun initializeHandler(notificationManager : NotificationManager){
        this.notificationManager = notificationManager
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
            "getSupportedDevices" -> result.success(getSupportedDevices(false))
            "getConnectedDevices" -> result.success(getSupportedDevices(true))
            "initDevice" -> {
                val friendlyName = methodCall.arguments as? String
                if (friendlyName == null) {
                    result.error("INVALID_ARGS", "Expected a String argument (friendlyName)", null)
                    return
                }
                result.success(initDevice(friendlyName))
            }
            "deinitDevice" -> result.success(deinitDevice())
            "getDeviceInfo" -> result.success(getDeviceInfo())
            "notify" -> {
                @Suppress("UNCHECKED_CAST")
                val commandMap = methodCall.arguments as? Map<String, Any?>
                if (commandMap == null) {
                    result.error("INVALID_ARGS", "Expected a Map argument (command)", null)
                    return
                }
                result.success(triggerNotification(commandMap))
            }
        }
    }
    // -----------------------------------------------------------------------

    // ---------------------------- EVENT CHANNEL ----------------------------
    private val eventChannelName = "zep/events/$handlerName"
    private var eventChannel: EventChannel? = null
    private var eventSink: EventChannel.EventSink? = null

    private fun setupEventChannel(messenger: BinaryMessenger) {
        eventChannel = EventChannel(messenger, eventChannelName)
        eventChannel?.setStreamHandler(this)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
    // -----------------------------------------------------------------------
    private var currentDevice: NotificationDevice? = null

    private fun getSupportedDevices(onlyConnected: Boolean): Map<String, Any?> {
        val devicesList = notificationManager.supportedDevicesInfo
            ?.filter { data -> !onlyConnected || data.isConnected }
            ?.map { data -> data.toMap() } ?: emptyList()

        return mapOf("devicesList" to devicesList)
    }

    private fun initDevice(friendlyName: String): Boolean {
        if(currentDevice != null) deinitDevice()

        val deviceInfo = notificationManager.supportedDevicesInfo
            ?.firstOrNull { it.friendlyName.equals(friendlyName, ignoreCase = true) }
            ?: return false

        if(!deviceInfo.isConnected) return false

        currentDevice = notificationManager.getDevice(deviceInfo)

        if(currentDevice != null){
            try{
                currentDevice!!.enable()
            }
            catch (error: NotificationException){
                deinitDevice()

                return false
            }

            return true
        }

        return false
    }

    private fun deinitDevice(): Boolean {
        if(currentDevice == null) return false

        try{
            currentDevice!!.disable()
            currentDevice!!.release()
        }
        catch (error: NotificationException){

        }
        finally {
            currentDevice = null
        }

        return true
    }

    private fun getDeviceInfo(): Map<String, Any?>? {
        if(currentDevice == null) return null

        return currentDevice!!.deviceInfo?.toMap()
    }

    private fun triggerNotification(commandMap: Map<String, Any?>): Boolean {
        if(currentDevice == null) return false

        val notification = getNotificationFromMap(commandMap)

        currentDevice!!.notify(notification)

        return true
    }

    private fun getNotificationFromMap(map: Map<String, Any?>) : Notification {
        val notification = Notification()

        @Suppress("UNCHECKED_CAST")
        val ledMap = map["led"] as? Map<String, Any?>
        if (ledMap != null) {
            val led = LEDParams()
            led.color = (ledMap["color"] as? Number)?.toInt() ?: 0
            led.onTime = (ledMap["onTime"] as? Number)?.toInt() ?: 0
            led.offTime = (ledMap["offTime"] as? Number)?.toInt() ?: 0
            led.repeatCount = (ledMap["repeatCount"] as? Number)?.toInt() ?: 0
            notification.led = led
        }

        @Suppress("UNCHECKED_CAST")
        val beepMap = map["beep"] as? Map<String, Any?>
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

        @Suppress("UNCHECKED_CAST")
        val vibrateMap = map["vibrate"] as? Map<String, Any?>
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

        return notification
    }
}