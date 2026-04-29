package dev.pecol.zebra_emdk_plugin

import android.content.Context
import android.content.pm.PackageManager
import android.database.Cursor
import android.os.Build
import android.util.Base64
import android.util.Log
import androidx.core.net.toUri
import com.symbol.emdk.ProfileManager
import com.symbol.emdk.ProfileManager.ResultData
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import com.symbol.emdk.ProfileManager.DataListener
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class ProfileManagerHandler : EventChannel.StreamHandler, MethodCallHandler, DataListener {
    private val handlerName: String = "profile_manager"
    private lateinit var profileManager: ProfileManager
    private lateinit var applicationContext: Context

    fun setupChannels(messenger: BinaryMessenger){
        setupMethodChannel(messenger)
        setupEventChannel(messenger)
    }

    fun initializeHandler(profileManager : ProfileManager, context: Context){
        this.profileManager = profileManager
        this.applicationContext = context
        profileManager.addDataListener(this)
    }

    // --------------------------- METHOD CHANNEL ----------------------------
    private val methodChannelName = "zep/methods/$handlerName"
    private var methodChannel: MethodChannel? = null

    private fun setupMethodChannel(messenger: BinaryMessenger) {
        methodChannel = MethodChannel(messenger, methodChannelName)
        methodChannel?.setMethodCallHandler(this)
    }

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        try {
            when (methodCall.method){
                "processProfile" -> {
                    val characteristics = methodCall.arguments as? String
                    if (characteristics == null) {
                        result.error("INVALID_ARGS", "characteristics must be non-null strings", null)
                        return
                    }

                    processProfile(characteristics)

                    result.success(true)
                }
                "requestServicePermission" -> {
                    val uriTarget = methodCall.arguments as? String
                    if (uriTarget == null) {
                        result.error("INVALID_ARGS", "Expected a String argument (uriTarget)", null)
                        return
                    }

                    requestServicePermission(uriTarget)

                    result.success(true)
                }
                "addKeyListener" -> {
                    val key = methodCall.arguments as? String
                    if (key == null) {
                        result.error("INVALID_ARGS", "Expected a String argument (key)", null)
                        return
                    }

                    addKeyListener(key)

                    result.success(true)
                }
                "resetAllKeyMappings" -> {
                    resetAllKeyMappings()

                    result.success(true)
                }
                "resolveCursorUri" -> {
                    val uriTarget = methodCall.arguments as? String
                    if (uriTarget == null) {
                        result.error("INVALID_ARGS", "Expected a String argument (uriTarget)", null)
                        return
                    }

                    result.success(resolveCursorUri(uriTarget))
                }
            }
        } catch (e: Exception) {
            Log.e("ProfileManagerHandler", "Unexpected exception in ${methodCall.method}: ${e.message}", e)
            result.error("NATIVE_EXCEPTION", e.message, null)
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
    private val pendingProfiles = LinkedHashMap<String, String>()
    private var isProcessing = false
    private var currentProfileName: String? = null

    override fun onData(resultData: ResultData?) {
        if (eventSink != null) {
            eventSink!!.sendEvent(
                "onData",
                resultData?.toMap() ?: emptyMap()
            )
        }

        synchronized(this) {
            if (currentProfileName != null) {
                pendingProfiles.remove(currentProfileName)
            }
            currentProfileName = null
            isProcessing = false
        }

        executeNextProfile()
    }

    private fun processProfile(characteristics: String) {
        val profileName = "Profile${System.nanoTime()}"

        val xmlData: String =   "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
                                "<characteristic type=\"Profile\">" +
                                    "<parm name=\"ProfileName\" value=\"$profileName\"/>" +
                                    characteristics +
                                "</characteristic>"

        synchronized(this) {
            pendingProfiles[profileName] = xmlData
        }

        executeNextProfile()
    }

    private fun executeNextProfile() {
        // Determine the next profile to run while holding the lock,
        // but perform the actual async call outside to avoid deadlocks
        // if the EMDK callback fires on the same thread.
        val entry: Map.Entry<String, String>?

        synchronized(this) {
            if (isProcessing || pendingProfiles.isEmpty()) return
            entry = pendingProfiles.entries.first()
            currentProfileName = entry!!.key
            isProcessing = true
        }

        profileManager.processProfileAsync(
            entry!!.key,
            ProfileManager.PROFILE_FLAG.SET,
            arrayOf(entry.value)
        )
    }

    private fun requestServicePermission(uriTarget: String) {
        val characteristic: String = "<characteristic type=\"AccessMgr\">" +
                "<parm name=\"OperationMode\" value=\"1\"/>" +
                "<parm name=\"ServiceAccessAction\" value=\"4\" />" +
                "<parm name=\"ServiceIdentifier\" value=\"$uriTarget\" />" +
                "<parm name=\"CallerPackageName\" value=\"${applicationContext.packageName}\" />" +
                "<parm name=\"CallerSignature\" value=\"${getAppSignature()}\" />" +
                "</characteristic>"

        processProfile(characteristic)
    }

    private fun addKeyListener(key: String) {
        val characteristic: String = "<characteristic type=\"KeyMappingMgr\">" +
                                    "<parm name=\"Action\" value=\"1\"/>" +
                                    "<characteristic type=\"KeyMapping\">" +
                                        "<parm name=\"KeyIdentifier\" value=\"$key\"/>" +
                                        "<characteristic type=\"BaseTable\">" +
                                            "<parm name=\"BaseBehavior\" value=\"3\"/>" +
                                            "<parm name=\"BaseSendIntent\" value=\"1\"/>" +
                                            "<parm name=\"BaseIntentType\" value=\"2\"/>" +
                                            "<parm name=\"BaseIntentAction\" value=\"${applicationContext.packageName}.KEY_DOWN_EVENT\"/>" +
                                            "<parm name=\"BaseIntentPackage\" value=\"${applicationContext.packageName}\"/>" +
                                            "<parm name=\"BaseIntentStringExtraName\" value=\"key\"/>" +
                                            "<parm name=\"BaseIntentStringExtraValue\" value=\"$key\"/>" +
                                        "</characteristic>" +
                                    "</characteristic>" +
                                    "</characteristic>"

        processProfile(characteristic)
    }

    private fun resetAllKeyMappings() {
        val characteristic: String = "<characteristic type=\"KeyMappingMgr\">" +
                                    "<parm name=\"Action\" value=\"2\"/>" +
                                    "</characteristic>"

        processProfile(characteristic)
    }

    private fun resolveCursorUri(uriTarget: String): String? {
        val uri = uriTarget.toUri()
        var cursor: Cursor? = null
        return try {
            cursor = applicationContext.contentResolver.query(uri, null, null, null, null)
            if (cursor != null && cursor.moveToFirst() && cursor.columnCount > 0) cursor.getString(0) else null
        } catch (e: Exception) {
            Log.w("resolveCursorUri", "resolveCursorUri() failed for '$uriTarget': ${e.message}")
            null
        } finally {
            cursor?.close()
        }
    }

    private fun getAppSignature(): String? {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.P) return null

        return try {
            val packageInfo = applicationContext.packageManager.getPackageInfo(
                applicationContext.packageName,
                PackageManager.GET_SIGNING_CERTIFICATES
            )
            if (packageInfo.signingInfo == null) return null
            val cert = packageInfo.signingInfo!!.apkContentsSigners[0].toByteArray()
            Base64.encodeToString(cert, Base64.NO_WRAP)
        } catch (e: Exception) {
            Log.w("getAppSignature", "getAppSignature() exception: ${e.message}")
            null
        }
    }
}