package dev.pecol.zebra_emdk_plugin

import android.os.Handler
import android.os.Looper
import com.symbol.emdk.ProfileManager
import com.symbol.emdk.barcode.ScanDataCollection
import com.symbol.emdk.barcode.ScannerInfo
import com.symbol.emdk.barcode.StatusData
import com.symbol.emdk.notification.DeviceInfo
import io.flutter.plugin.common.EventChannel

fun EventChannel.EventSink.sendEvent(type: String, payload: Map<String, Any?> = emptyMap()) {
    val event = mapOf(
        "type" to type,
        "payload" to payload,
        "timestamp" to System.currentTimeMillis()
    )
    Handler(Looper.getMainLooper()).post {
        success(event)
    }
}

fun ScanDataCollection.toMap(): Map<String, Any?> {
    val scanDataList = scanData?.map { data ->
        mapOf(
            "data" to data.data,
            "labelType" to data.labelType.name,
            "rawData" to data.rawData,
            "timeStamp" to data.timeStamp
        )
    } ?: emptyList<Map<String, Any?>>()

    val tokensList = tokenizedData?.tokens?.map { token ->
        mapOf(
            "data" to token.data,
            "dataType" to token.dataType,
            "format" to token.format,
            "key" to token.key,
            "rawData" to token.rawData
        )
    } ?: emptyList<Map<String, Any?>>()

    val tokenizedDataMap = mapOf(
        "tokens" to tokensList
    )

    return mapOf(
        "friendlyName" to friendlyName,
        "labelIdentifier" to labelIdentifier,
        "scannerResult" to result?.name,
        "scanData" to scanDataList,
        "tokenizedData" to tokenizedDataMap
    )
}

fun ScannerInfo.toMap(): Map<String, Any?> {
    return mapOf(
        "connectionType" to connectionType?.name,
        "decoderType" to decoderType?.name,
        "deviceIdentifier" to deviceIdentifier?.name,
        "deviceType" to deviceType?.name,
        "friendlyName" to friendlyName,
        "isConnected" to isConnected,
        "isDefaultScanner" to isDefaultScanner,
        "modelNumber" to modelNumber
    )
}

fun StatusData.toMap(): Map<String, Any?> {
    return mapOf(
        "friendlyName" to friendlyName,
        "state" to state?.name,
    )
}

fun DeviceInfo.toMap(): Map<String, Any?> {
    return mapOf(
        "friendlyName" to friendlyName,
        "modelNumber" to modelNumber,
        "deviceType" to deviceType?.name,
        "connectionType" to connectionType?.name,
        "deviceIdentifier" to deviceIdentifier?.name,
        "isDefaultDevice" to isDefaultDevice,
        "isConnected" to isConnected,
        "isLEDSupported" to isLEDSupported,
        "isBeepSupported" to isBeepSupported,
        "isVibrateSupported" to isVibrateSupported
    )
}

fun ProfileManager.ResultData.toMap(): Map<String, Any?> {
    return mapOf(
        "result" to mapOf(
            "statusCode" to result.statusCode.name,
            "extendedStatusCode" to result.extendedStatusCode.name,
            "statusString" to result.statusString
        ),
        "profileName" to profileName,
        "profileFlag" to profileFlag.name,
        "profileString" to profileString
    )
}