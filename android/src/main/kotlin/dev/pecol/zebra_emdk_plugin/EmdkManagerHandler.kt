package dev.pecol.zebra_emdk_plugin

import android.content.Context
import com.symbol.emdk.EMDKManager
import com.symbol.emdk.EMDKManager.EMDKListener
import com.symbol.emdk.ProfileManager
import com.symbol.emdk.barcode.BarcodeManager
import com.symbol.emdk.notification.NotificationManager
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class EmdkManagerHandler : StreamHandler, MethodCallHandler, EMDKListener {
    private val handlerName: String = "emdk_manager"
    private lateinit var emdkManager: EMDKManager
    private lateinit var applicationContext: Context

    private var barcodeManagerHandler: BarcodeManagerHandler = BarcodeManagerHandler()
    private var notificationManagerHandler: NotificationManagerHandler = NotificationManagerHandler()
    private var profileManagerHandler: ProfileManagerHandler = ProfileManagerHandler()

    fun setupChannels(messenger: BinaryMessenger){
        setupMethodChannel(messenger)
        setupEventChannel(messenger)

        barcodeManagerHandler.setupChannels(messenger)
        notificationManagerHandler.setupChannels(messenger)
        profileManagerHandler.setupChannels(messenger)
    }

    fun initializeHandler(context: Context) {
        applicationContext = context
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
            "initialize" -> result.success(initialize())
            "dispose" -> {
                emdkManager.release()
                result.success(true)
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
    private fun initialize() : String {
        val results = EMDKManager.getEMDKManager(applicationContext, this)
        return results.statusCode.name
    }

    override fun onOpened(emdkManager: EMDKManager?) {
        if(emdkManager == null) return

        this.emdkManager = emdkManager

        val barcodeManager: BarcodeManager = emdkManager.getInstance(EMDKManager.FEATURE_TYPE.BARCODE) as BarcodeManager
        barcodeManagerHandler.initializeHandler(barcodeManager)

        val notificationManager: NotificationManager = emdkManager.getInstance(EMDKManager.FEATURE_TYPE.NOTIFICATION) as NotificationManager
        notificationManagerHandler.initializeHandler(notificationManager)

        val profileManager: ProfileManager = emdkManager.getInstance(EMDKManager.FEATURE_TYPE.PROFILE) as ProfileManager
        profileManagerHandler.initializeHandler(profileManager, applicationContext)

        eventSink?.sendEvent("onOpened")
    }

    override fun onClosed() {
        emdkManager.release()

        eventSink?.sendEvent("onClosed")
    }
}