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
            "resolveCursorUri" -> {
                val uriTarget = methodCall.arguments as? String
                if (uriTarget == null) {
                    result.error("INVALID_ARGS", "Expected a String argument (uriTarget)", null)
                    return
                }

                result.success(resolveCursorUri(uriTarget))
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
    private val pendingProfiles = LinkedHashMap<String, String>()
    private var isProcessing = false
    private var currentProfileName: String? = null

    override fun onData(resultData: ResultData?) {
        val finishedProfile = currentProfileName

        synchronized(this) {
            if (finishedProfile != null) {
                pendingProfiles.remove(finishedProfile)
            }

            currentProfileName = null
            isProcessing = false
        }

        if (eventSink != null) {
            eventSink!!.sendEvent(
                "onData",
                resultData?.toMap() ?: emptyMap()
            )
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
        synchronized(this) {
            if (isProcessing) return
            if (pendingProfiles.isEmpty()) return

            val firstEntry = pendingProfiles.entries.first()

            currentProfileName = firstEntry.key
            isProcessing = true

            profileManager.processProfileAsync(
                firstEntry.key,
                ProfileManager.PROFILE_FLAG.SET,
                arrayOf(firstEntry.value)
            )
        }
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