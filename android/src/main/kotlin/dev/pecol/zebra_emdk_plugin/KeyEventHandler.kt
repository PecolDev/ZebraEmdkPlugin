package dev.pecol.zebra_emdk_plugin

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class KeyEventHandler : StreamHandler, MethodCallHandler {
    private val handlerName: String = "key_event"
    private lateinit var applicationContext: Context

    private lateinit var actionKeyDown: String

    fun setupChannels(messenger: BinaryMessenger) {
        setupMethodChannel(messenger)
        setupEventChannel(messenger)
    }

    fun initializeHandler(context: Context) {
        // Use the Application context — not the Activity — so the receiver's
        // lifetime is not tied to the Activity. This prevents the
        // IntentReceiverLeaked error on Activity destroy / hot-restart.
        applicationContext = context.applicationContext
        actionKeyDown = "${context.packageName}.KEY_DOWN_EVENT"
        registerKeyDownReceiver()
    }

    fun dispose() {
        unregisterKeyDownReceiver()
    }

    // --------------------------- METHOD CHANNEL ----------------------------
    private val methodChannelName = "zep/methods/$handlerName"
    private var methodChannel: MethodChannel? = null

    private fun setupMethodChannel(messenger: BinaryMessenger) {
        methodChannel = MethodChannel(messenger, methodChannelName)
        methodChannel?.setMethodCallHandler(this)
    }

    // No method calls needed — the receiver is always active.
    // The MethodChannel is kept for potential future use (e.g. pause/resume).
    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        result.notImplemented()
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

    // -------------------------- BROADCAST RECEIVER -------------------------
    private var keyDownReceiver: BroadcastReceiver? = null

    private fun registerKeyDownReceiver() {
        if (keyDownReceiver != null) return

        keyDownReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                if (intent?.action != actionKeyDown) return

                val key = intent.getStringExtra("key")
                if (key == null) {
                    Log.w("KeyEventHandler", "Received $actionKeyDown but 'key' extra is missing")
                    return
                }

                Log.d("KeyEventHandler", "Key event received: $key")
                eventSink?.sendEvent("onKeyDown", mapOf("key" to key))
            }
        }

        val filter = IntentFilter(actionKeyDown)

        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                // Android 13+: must declare exported/not-exported.
                // Zebra MX sends the intent from an external process, so RECEIVER_EXPORTED is required.
                applicationContext.registerReceiver(keyDownReceiver, filter, Context.RECEIVER_EXPORTED)
            } else {
                applicationContext.registerReceiver(keyDownReceiver, filter)
            }
            Log.d("KeyEventHandler", "Registered receiver for $actionKeyDown")
        } catch (e: Exception) {
            Log.e("KeyEventHandler", "Failed to register receiver: ${e.message}", e)
        }
    }

    private fun unregisterKeyDownReceiver() {
        keyDownReceiver?.let {
            try {
                applicationContext.unregisterReceiver(it)
                Log.d("KeyEventHandler", "Unregistered receiver for $actionKeyDown")
            } catch (e: Exception) {
                Log.w("KeyEventHandler", "unregisterReceiver failed: ${e.message}")
            }
            keyDownReceiver = null
        }
    }
    // -----------------------------------------------------------------------
}
