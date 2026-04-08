// ================= FILE: scanner_config.dart =================

import 'package:zebra_emdk_plugin/generated/decoder_params.dart';

/// Configuration class for the Zebra barcode scanner.
///
/// Controls all aspects of scanner behaviour including scan parameters,
/// reader parameters, decoder parameters, and multi-barcode modes.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class ScannerConfig {
  /// Determines behaviour when an unsupported parameter is encountered.
  final SkipOnUnSupported? skipOnUnsupported;

  /// Parameters that control the scan session (audio, LED, etc.).
  final ScanParams? scanParams;

  /// Decoder parameters controlling which symbologies are enabled and their options.
  final DecoderParams? decoderParams;

  /// Reader parameters controlling the hardware scanner behaviour.
  final ReaderParams? readerParams;

  /// NG SimulScan parameters for multi-barcode scanning.
  final NGSimulScanParams? ngSimulScanParams;

  /// UDI (Unique Device Identifier) parsing parameters.
  final UdiParams? udiParams;

  /// Multi-barcode scanning parameters.
  final MultiBarcodeParams? multiBarcodeParams;

  /// OCR (Optical Character Recognition) parameters.
  final OcrParams? ocrParams;

  const ScannerConfig({
    this.skipOnUnsupported,
    this.scanParams,
    this.decoderParams,
    this.readerParams,
    this.ngSimulScanParams,
    this.udiParams,
    this.multiBarcodeParams,
    this.ocrParams,
  });

  factory ScannerConfig.fromMap(Map<String, dynamic> map) {
    return ScannerConfig(
      skipOnUnsupported: map['skipOnUnsupported'] != null
          ? SkipOnUnSupported.fromValue(map['skipOnUnsupported'] as String)
          : null,
      scanParams: map['scanParams'] != null
          ? ScanParams.fromMap(Map<String, dynamic>.from(map['scanParams']))
          : null,
      decoderParams: map['decoderParams'] != null
          ? DecoderParams.fromMap(Map<String, dynamic>.from(map['decoderParams']))
          : null,
      readerParams: map['readerParams'] != null
          ? ReaderParams.fromMap(Map<String, dynamic>.from(map['readerParams']))
          : null,
      ngSimulScanParams: map['ngSimulScanParams'] != null
          ? NGSimulScanParams.fromMap(Map<String, dynamic>.from(map['ngSimulScanParams']))
          : null,
      udiParams: map['udiParams'] != null
          ? UdiParams.fromMap(Map<String, dynamic>.from(map['udiParams']))
          : null,
      multiBarcodeParams: map['multiBarcodeParams'] != null
          ? MultiBarcodeParams.fromMap(Map<String, dynamic>.from(map['multiBarcodeParams']))
          : null,
      ocrParams: map['ocrParams'] != null
          ? OcrParams.fromMap(Map<String, dynamic>.from(map['ocrParams']))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'skipOnUnsupported': skipOnUnsupported?.value,
      'scanParams': scanParams?.toMap(),
      'decoderParams': decoderParams?.toMap(),
      'readerParams': readerParams?.toMap(),
      'ngSimulScanParams': ngSimulScanParams?.toMap(),
      'udiParams': udiParams?.toMap(),
      'multiBarcodeParams': multiBarcodeParams?.toMap(),
      'ocrParams': ocrParams?.toMap(),
    };
  }
}

// ---------------------------------------------------------------------------
// ScanParams
// ---------------------------------------------------------------------------

/// Parameters controlling the scan session feedback and output format.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class ScanParams {
  /// The code ID type prepended to barcode data.
  final CodeIdType? codeIdType;

  /// URI of the audio file to play on a successful decode.
  final String? decodeAudioFeedbackUri;

  /// Whether to provide haptic (vibration) feedback on decode.
  final bool? decodeHapticFeedback;

  /// Duration in milliseconds of the decode LED indicator.
  final int? decodeLEDTime;

  /// Audio stream type used for the decode beep.
  final AudioStreamType? audioStreamType;

  /// Whether to illuminate the LED on decode.
  final bool? decodeLEDFeedback;

  /// LED feedback mode for remote scanners.
  final DecodeLEDFeedbackMode? decodeLEDFeedbackMode;

  /// Audio feedback mode for remote scanners.
  final DecodeAudioFeedbackMode? decodeAudioFeedbackMode;

  /// Whether to show an on-screen notification on decode.
  final bool? decodeScreenNotification;

  /// Duration in milliseconds for the on-screen decode notification.
  final int? decodeScreenNotificationTime;

  /// Translucency level (0–100) of the on-screen decode notification.
  final int? decodeScreenTranslucencyLevel;

  const ScanParams({
    this.codeIdType,
    this.decodeAudioFeedbackUri,
    this.decodeHapticFeedback,
    this.decodeLEDTime,
    this.audioStreamType,
    this.decodeLEDFeedback,
    this.decodeLEDFeedbackMode,
    this.decodeAudioFeedbackMode,
    this.decodeScreenNotification,
    this.decodeScreenNotificationTime,
    this.decodeScreenTranslucencyLevel,
  });

  factory ScanParams.fromMap(Map<String, dynamic> map) {
    return ScanParams(
      codeIdType: map['codeIdType'] != null
          ? CodeIdType.fromValue(map['codeIdType'] as String)
          : null,
      decodeAudioFeedbackUri: map['decodeAudioFeedbackUri'] as String?,
      decodeHapticFeedback: map['decodeHapticFeedback'] as bool?,
      decodeLEDTime: map['decodeLEDTime'] as int?,
      audioStreamType: map['audioStreamType'] != null
          ? AudioStreamType.fromValue(map['audioStreamType'] as String)
          : null,
      decodeLEDFeedback: map['decodeLEDFeedback'] as bool?,
      decodeLEDFeedbackMode: map['decodeLEDFeedbackMode'] != null
          ? DecodeLEDFeedbackMode.fromValue(map['decodeLEDFeedbackMode'] as String)
          : null,
      decodeAudioFeedbackMode: map['decodeAudioFeedbackMode'] != null
          ? DecodeAudioFeedbackMode.fromValue(map['decodeAudioFeedbackMode'] as String)
          : null,
      decodeScreenNotification: map['decodeScreenNotification'] as bool?,
      decodeScreenNotificationTime: map['decodeScreenNotificationTime'] as int?,
      decodeScreenTranslucencyLevel: map['decodeScreenTranslucencyLevel'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'codeIdType': codeIdType?.value,
      'decodeAudioFeedbackUri': decodeAudioFeedbackUri,
      'decodeHapticFeedback': decodeHapticFeedback,
      'decodeLEDTime': decodeLEDTime,
      'audioStreamType': audioStreamType?.value,
      'decodeLEDFeedback': decodeLEDFeedback,
      'decodeLEDFeedbackMode': decodeLEDFeedbackMode?.value,
      'decodeAudioFeedbackMode': decodeAudioFeedbackMode?.value,
      'decodeScreenNotification': decodeScreenNotification,
      'decodeScreenNotificationTime': decodeScreenNotificationTime,
      'decodeScreenTranslucencyLevel': decodeScreenTranslucencyLevel,
    };
  }
}

// ---------------------------------------------------------------------------
// ReaderParams
// ---------------------------------------------------------------------------

/// Top-level reader hardware parameters.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class ReaderParams {
  /// Reader-specific parameters that vary by device type.
  final ReaderSpecific? readerSpecific;

  const ReaderParams({this.readerSpecific});

  factory ReaderParams.fromMap(Map<String, dynamic> map) {
    return ReaderParams(
      readerSpecific: map['readerSpecific'] != null
          ? ReaderSpecific.fromMap(Map<String, dynamic>.from(map['readerSpecific']))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {'readerSpecific': readerSpecific?.toMap()};
  }
}

/// Reader-specific parameters; contains sub-objects for each scanner type.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class ReaderSpecific {
  /// Parameters specific to imager scanners.
  final ImagerSpecific? imagerSpecific;

  /// Parameters specific to camera scanners.
  final CameraSpecific? cameraSpecific;

  /// Parameters specific to laser scanners.
  final LaserSpecific? laserSpecific;

  const ReaderSpecific({
    this.imagerSpecific,
    this.cameraSpecific,
    this.laserSpecific,
  });

  factory ReaderSpecific.fromMap(Map<String, dynamic> map) {
    return ReaderSpecific(
      imagerSpecific: map['imagerSpecific'] != null
          ? ImagerSpecific.fromMap(Map<String, dynamic>.from(map['imagerSpecific']))
          : null,
      cameraSpecific: map['cameraSpecific'] != null
          ? CameraSpecific.fromMap(Map<String, dynamic>.from(map['cameraSpecific']))
          : null,
      laserSpecific: map['laserSpecific'] != null
          ? LaserSpecific.fromMap(Map<String, dynamic>.from(map['laserSpecific']))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imagerSpecific': imagerSpecific?.toMap(),
      'cameraSpecific': cameraSpecific?.toMap(),
      'laserSpecific': laserSpecific?.toMap(),
    };
  }
}

/// Continuous read parameters shared by multiple reader types.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class ContinuousRead {
  /// Whether continuous scan mode is enabled.
  final bool? isContinuousScan;

  /// Timeout (ms) before the same symbol can be decoded again.
  final int? sameSymbolTimeout;

  /// Timeout (ms) before a different symbol can be decoded.
  final int? differentSymbolTimeout;

  const ContinuousRead({
    this.isContinuousScan,
    this.sameSymbolTimeout,
    this.differentSymbolTimeout,
  });

  factory ContinuousRead.fromMap(Map<String, dynamic> map) {
    return ContinuousRead(
      isContinuousScan: map['isContinuousScan'] as bool?,
      sameSymbolTimeout: map['sameSymbolTimeout'] as int?,
      differentSymbolTimeout: map['differentSymbolTimeout'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isContinuousScan': isContinuousScan,
      'sameSymbolTimeout': sameSymbolTimeout,
      'differentSymbolTimeout': differentSymbolTimeout,
    };
  }
}

/// Presentation mode parameters for imager scanners.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class PresentationModeParams {
  /// Sensitivity level of presentation mode.
  final PresentationModeSensitivity? sensitivity;

  const PresentationModeParams({this.sensitivity});

  factory PresentationModeParams.fromMap(Map<String, dynamic> map) {
    return PresentationModeParams(
      sensitivity: map['sensitivity'] != null
          ? PresentationModeSensitivity.fromValue(map['sensitivity'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {'sensitivity': sensitivity?.value};
  }
}

/// Parameters specific to imager-type scanners.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class ImagerSpecific {
  /// Presentation mode parameters.
  final PresentationModeParams? presentationModeParams;

  /// Continuous read parameters.
  final ContinuousRead? continuousRead;

  /// Beam timer (ms); how long the scanner stays on after trigger.
  final int? beamTimer;

  /// Linear security level.
  final LinearSecurityLevel? linearSecurityLevel;

  /// Picklist mode setting.
  final PickList? pickList;

  /// Extended picklist mode setting.
  final PicklistEx? picklistEx;

  /// LCD mode for reflective displays.
  final LcdMode? lcdMode;

  /// Inverse 1D barcode decoding mode.
  final Inverse1DMode? inverse1DMode;

  /// Illumination brightness level (0–10).
  final int? illuminationBrightness;

  /// Whether to disconnect scanner on application exit.
  final bool? disconnectOnExit;

  /// Idle timeout (seconds) before disconnecting.
  final int? connectionIdleTime;

  /// Illumination mode (LED on/off).
  final IlluminationMode? illuminationMode;

  /// Aiming pattern mode.
  final AimingPattern? aimingPattern;

  /// 1D quiet zone tolerance level.
  final OneDQuietZoneLevel? oneDQuietZoneLevel;

  /// Effort level for decoding poor-quality barcodes.
  final PoorQualityDecodeEffortLevel? poorQualityDecodeEffortLevel;

  /// Aim type for triggering.
  final AimType? aimType;

  /// Duration (ms) of the aiming beam before scanning.
  final int? aimTimer;

  /// Timeout (ms) for same-symbol re-read.
  final int? sameSymbolTimeout;

  /// Timeout (ms) for different-symbol re-read.
  final int? differentSymbolTimeout;

  /// Whether to re-pair after scanner reboot.
  final PairAfterScannerReboot? pairAfterScannerReboot;

  /// Scan mode (single, UDI, multi-barcode).
  final ScanMode? scanMode;

  /// Whether Digimarc decoding is enabled.
  final bool? digimarcDecoding;

  /// Character set selection for decoded data.
  final CharacterSet? characterSetSelection;

  /// Failure option for auto character set detection.
  final AutoCharacterSetFailureOption? autoCharacterSetFailureOption;

  /// Preferred character set ordering for auto detection.
  final List<AutoCharacterSetPreference>? autoCharacterSetPreferredOrder;

  /// Scene detection qualifier for smarter triggering.
  final SceneDetectionQualifier? sceneDetectionQualifier;

  /// DPM (Direct Part Mark) mode.
  final DpmModes? dpmMode;

  /// DPM illumination control.
  final DpmIlluminationControl? dpmIlluminationControl;

  const ImagerSpecific({
    this.presentationModeParams,
    this.continuousRead,
    this.beamTimer,
    this.linearSecurityLevel,
    this.pickList,
    this.picklistEx,
    this.lcdMode,
    this.inverse1DMode,
    this.illuminationBrightness,
    this.disconnectOnExit,
    this.connectionIdleTime,
    this.illuminationMode,
    this.aimingPattern,
    this.oneDQuietZoneLevel,
    this.poorQualityDecodeEffortLevel,
    this.aimType,
    this.aimTimer,
    this.sameSymbolTimeout,
    this.differentSymbolTimeout,
    this.pairAfterScannerReboot,
    this.scanMode,
    this.digimarcDecoding,
    this.characterSetSelection,
    this.autoCharacterSetFailureOption,
    this.autoCharacterSetPreferredOrder,
    this.sceneDetectionQualifier,
    this.dpmMode,
    this.dpmIlluminationControl,
  });

  factory ImagerSpecific.fromMap(Map<String, dynamic> map) {
    return ImagerSpecific(
      presentationModeParams: map['presentationModeParams'] != null
          ? PresentationModeParams.fromMap(Map<String, dynamic>.from(map['presentationModeParams']))
          : null,
      continuousRead: map['continuousRead'] != null
          ? ContinuousRead.fromMap(Map<String, dynamic>.from(map['continuousRead']))
          : null,
      beamTimer: map['beamTimer'] as int?,
      linearSecurityLevel: map['linearSecurityLevel'] != null
          ? LinearSecurityLevel.fromValue(map['linearSecurityLevel'] as String)
          : null,
      pickList: map['pickList'] != null
          ? PickList.fromValue(map['pickList'] as String)
          : null,
      picklistEx: map['picklistEx'] != null
          ? PicklistEx.fromValue(map['picklistEx'] as String)
          : null,
      lcdMode: map['lcdMode'] != null
          ? LcdMode.fromValue(map['lcdMode'] as String)
          : null,
      inverse1DMode: map['inverse1DMode'] != null
          ? Inverse1DMode.fromValue(map['inverse1DMode'] as String)
          : null,
      illuminationBrightness: map['illuminationBrightness'] as int?,
      disconnectOnExit: map['disconnectOnExit'] as bool?,
      connectionIdleTime: map['connectionIdleTime'] as int?,
      illuminationMode: map['illuminationMode'] != null
          ? IlluminationMode.fromValue(map['illuminationMode'] as String)
          : null,
      aimingPattern: map['aimingPattern'] != null
          ? AimingPattern.fromValue(map['aimingPattern'] as String)
          : null,
      oneDQuietZoneLevel: map['oneDQuietZoneLevel'] != null
          ? OneDQuietZoneLevel.fromValue(map['oneDQuietZoneLevel'] as String)
          : null,
      poorQualityDecodeEffortLevel: map['poorQualityDecodeEffortLevel'] != null
          ? PoorQualityDecodeEffortLevel.fromValue(map['poorQualityDecodeEffortLevel'] as String)
          : null,
      aimType: map['aimType'] != null
          ? AimType.fromValue(map['aimType'] as String)
          : null,
      aimTimer: map['aimTimer'] as int?,
      sameSymbolTimeout: map['sameSymbolTimeout'] as int?,
      differentSymbolTimeout: map['differentSymbolTimeout'] as int?,
      pairAfterScannerReboot: map['pairAfterScannerReboot'] != null
          ? PairAfterScannerReboot.fromValue(map['pairAfterScannerReboot'] as String)
          : null,
      scanMode: map['scanMode'] != null
          ? ScanMode.fromValue(map['scanMode'] as String)
          : null,
      digimarcDecoding: map['digimarcDecoding'] as bool?,
      characterSetSelection: map['characterSetSelection'] != null
          ? CharacterSet.fromValue(map['characterSetSelection'] as String)
          : null,
      autoCharacterSetFailureOption: map['autoCharacterSetFailureOption'] != null
          ? AutoCharacterSetFailureOption.fromValue(map['autoCharacterSetFailureOption'] as String)
          : null,
      autoCharacterSetPreferredOrder: map['autoCharacterSetPreferredOrder'] != null
          ? List<AutoCharacterSetPreference>.from(
              (map['autoCharacterSetPreferredOrder'] as List)
                  .map((e) => AutoCharacterSetPreference.fromValue(e as String)),
            )
          : null,
      sceneDetectionQualifier: map['sceneDetectionQualifier'] != null
          ? SceneDetectionQualifier.fromValue(map['sceneDetectionQualifier'] as String)
          : null,
      dpmMode: map['dpmMode'] != null
          ? DpmModes.fromValue(map['dpmMode'] as String)
          : null,
      dpmIlluminationControl: map['dpmIlluminationControl'] != null
          ? DpmIlluminationControl.fromValue(map['dpmIlluminationControl'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'presentationModeParams': presentationModeParams?.toMap(),
      'continuousRead': continuousRead?.toMap(),
      'beamTimer': beamTimer,
      'linearSecurityLevel': linearSecurityLevel?.value,
      'pickList': pickList?.value,
      'picklistEx': picklistEx?.value,
      'lcdMode': lcdMode?.value,
      'inverse1DMode': inverse1DMode?.value,
      'illuminationBrightness': illuminationBrightness,
      'disconnectOnExit': disconnectOnExit,
      'connectionIdleTime': connectionIdleTime,
      'illuminationMode': illuminationMode?.value,
      'aimingPattern': aimingPattern?.value,
      'oneDQuietZoneLevel': oneDQuietZoneLevel?.value,
      'poorQualityDecodeEffortLevel': poorQualityDecodeEffortLevel?.value,
      'aimType': aimType?.value,
      'aimTimer': aimTimer,
      'sameSymbolTimeout': sameSymbolTimeout,
      'differentSymbolTimeout': differentSymbolTimeout,
      'pairAfterScannerReboot': pairAfterScannerReboot?.value,
      'scanMode': scanMode?.value,
      'digimarcDecoding': digimarcDecoding,
      'characterSetSelection': characterSetSelection?.value,
      'autoCharacterSetFailureOption': autoCharacterSetFailureOption?.value,
      'autoCharacterSetPreferredOrder':
          autoCharacterSetPreferredOrder?.map((e) => e.value).toList(),
      'sceneDetectionQualifier': sceneDetectionQualifier?.value,
      'dpmMode': dpmMode?.value,
      'dpmIlluminationControl': dpmIlluminationControl?.value,
    };
  }
}

/// Parameters specific to laser-type scanners.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class LaserSpecific {
  /// Continuous read parameters.
  final ContinuousRead? continuousRead;

  /// Duration (ms) the beam stays on after trigger.
  final int? beamTimer;

  /// Linear security level.
  final LinearSecurityLevel? linearSecurityLevel;

  /// Inverse 1D barcode decoding mode.
  final Inverse1DMode? inverse1DMode;

  /// Power mode for laser.
  final PowerMode? powerMode;

  /// 1D quiet zone tolerance level.
  final OneDQuietZoneLevel? oneDQuietZoneLevel;

  /// Effort level for decoding poor-quality barcodes.
  final PoorQualityDecodeEffortLevel? poorQualityDecodeEffortLevel;

  /// Adaptive scanning mode.
  final AdaptiveScanning? adaptiveScanning;

  /// Beam width setting.
  final BeamWidth? beamWidth;

  /// Aim type for triggering.
  final AimType? aimType;

  /// Duration (ms) of the aiming beam.
  final int? aimTimer;

  /// Timeout (ms) for same-symbol re-read.
  final int? sameSymbolTimeout;

  /// Timeout (ms) for different-symbol re-read.
  final int? differentSymbolTimeout;

  /// Character set for decoded data.
  final CharacterSet? characterSetSelection;

  /// Failure option for auto character set detection.
  final AutoCharacterSetFailureOption? autoCharacterSetFailureOption;

  /// Preferred character set order for auto detection.
  final List<AutoCharacterSetPreference>? autoCharacterSetPreferredOrder;

  /// Whether to disconnect scanner on application exit.
  final bool? disconnectOnExit;

  /// Idle timeout (seconds) before disconnecting.
  final int? connectionIdleTime;

  /// Whether to re-pair after scanner reboot.
  final PairAfterScannerReboot? pairAfterScannerReboot;

  const LaserSpecific({
    this.continuousRead,
    this.beamTimer,
    this.linearSecurityLevel,
    this.inverse1DMode,
    this.powerMode,
    this.oneDQuietZoneLevel,
    this.poorQualityDecodeEffortLevel,
    this.adaptiveScanning,
    this.beamWidth,
    this.aimType,
    this.aimTimer,
    this.sameSymbolTimeout,
    this.differentSymbolTimeout,
    this.characterSetSelection,
    this.autoCharacterSetFailureOption,
    this.autoCharacterSetPreferredOrder,
    this.disconnectOnExit,
    this.connectionIdleTime,
    this.pairAfterScannerReboot,
  });

  factory LaserSpecific.fromMap(Map<String, dynamic> map) {
    return LaserSpecific(
      continuousRead: map['continuousRead'] != null
          ? ContinuousRead.fromMap(Map<String, dynamic>.from(map['continuousRead']))
          : null,
      beamTimer: map['beamTimer'] as int?,
      linearSecurityLevel: map['linearSecurityLevel'] != null
          ? LinearSecurityLevel.fromValue(map['linearSecurityLevel'] as String)
          : null,
      inverse1DMode: map['inverse1DMode'] != null
          ? Inverse1DMode.fromValue(map['inverse1DMode'] as String)
          : null,
      powerMode: map['powerMode'] != null
          ? PowerMode.fromValue(map['powerMode'] as String)
          : null,
      oneDQuietZoneLevel: map['oneDQuietZoneLevel'] != null
          ? OneDQuietZoneLevel.fromValue(map['oneDQuietZoneLevel'] as String)
          : null,
      poorQualityDecodeEffortLevel: map['poorQualityDecodeEffortLevel'] != null
          ? PoorQualityDecodeEffortLevel.fromValue(map['poorQualityDecodeEffortLevel'] as String)
          : null,
      adaptiveScanning: map['adaptiveScanning'] != null
          ? AdaptiveScanning.fromValue(map['adaptiveScanning'] as String)
          : null,
      beamWidth: map['beamWidth'] != null
          ? BeamWidth.fromValue(map['beamWidth'] as String)
          : null,
      aimType: map['aimType'] != null
          ? AimType.fromValue(map['aimType'] as String)
          : null,
      aimTimer: map['aimTimer'] as int?,
      sameSymbolTimeout: map['sameSymbolTimeout'] as int?,
      differentSymbolTimeout: map['differentSymbolTimeout'] as int?,
      characterSetSelection: map['characterSetSelection'] != null
          ? CharacterSet.fromValue(map['characterSetSelection'] as String)
          : null,
      autoCharacterSetFailureOption: map['autoCharacterSetFailureOption'] != null
          ? AutoCharacterSetFailureOption.fromValue(map['autoCharacterSetFailureOption'] as String)
          : null,
      autoCharacterSetPreferredOrder: map['autoCharacterSetPreferredOrder'] != null
          ? List<AutoCharacterSetPreference>.from(
              (map['autoCharacterSetPreferredOrder'] as List)
                  .map((e) => AutoCharacterSetPreference.fromValue(e as String)),
            )
          : null,
      disconnectOnExit: map['disconnectOnExit'] as bool?,
      connectionIdleTime: map['connectionIdleTime'] as int?,
      pairAfterScannerReboot: map['pairAfterScannerReboot'] != null
          ? PairAfterScannerReboot.fromValue(map['pairAfterScannerReboot'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'continuousRead': continuousRead?.toMap(),
      'beamTimer': beamTimer,
      'linearSecurityLevel': linearSecurityLevel?.value,
      'inverse1DMode': inverse1DMode?.value,
      'powerMode': powerMode?.value,
      'oneDQuietZoneLevel': oneDQuietZoneLevel?.value,
      'poorQualityDecodeEffortLevel': poorQualityDecodeEffortLevel?.value,
      'adaptiveScanning': adaptiveScanning?.value,
      'beamWidth': beamWidth?.value,
      'aimType': aimType?.value,
      'aimTimer': aimTimer,
      'sameSymbolTimeout': sameSymbolTimeout,
      'differentSymbolTimeout': differentSymbolTimeout,
      'characterSetSelection': characterSetSelection?.value,
      'autoCharacterSetFailureOption': autoCharacterSetFailureOption?.value,
      'autoCharacterSetPreferredOrder':
          autoCharacterSetPreferredOrder?.map((e) => e.value).toList(),
      'disconnectOnExit': disconnectOnExit,
      'connectionIdleTime': connectionIdleTime,
      'pairAfterScannerReboot': pairAfterScannerReboot?.value,
    };
  }
}

/// Parameters specific to camera-type scanners.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class CameraSpecific {
  /// Continuous read parameters.
  final ContinuousRead? continuousRead;

  /// Duration (ms) the beam stays on after trigger.
  final int? beamTimer;

  /// Viewfinder width as a percentage of the screen.
  final int? viewfinderSize;

  /// Horizontal offset of the viewfinder.
  final int? viewfinderOffsetX;

  /// Vertical offset of the viewfinder.
  final int? viewfinderOffsetY;

  /// Linear security level.
  final LinearSecurityLevel? linearSecurityLevel;

  /// Illumination (torch) mode.
  final IlluminationMode? illuminationMode;

  /// Inverse 1D barcode decoding mode.
  final Inverse1DMode? inverse1DMode;

  /// Viewfinder display mode.
  final ViewFinderMode? viewfinderMode;

  /// 1D quiet zone tolerance level.
  final OneDQuietZoneLevel? oneDQuietZoneLevel;

  /// Effort level for decoding poor-quality barcodes.
  final PoorQualityDecodeEffortLevel? poorQualityDecodeEffortLevel;

  /// Extended picklist mode setting.
  final PicklistEx? picklistEx;

  /// Aim type for triggering.
  final AimType? aimType;

  /// Duration (ms) of the aiming phase.
  final int? aimTimer;

  /// Timeout (ms) for same-symbol re-read.
  final int? sameSymbolTimeout;

  /// Timeout (ms) for different-symbol re-read.
  final int? differentSymbolTimeout;

  /// Character set for decoded data.
  final CharacterSet? characterSetSelection;

  /// Failure option for auto character set detection.
  final AutoCharacterSetFailureOption? autoCharacterSetFailureOption;

  /// Preferred character set order for auto detection.
  final List<AutoCharacterSetPreference>? autoCharacterSetPreferredOrder;

  /// Scan mode (single, UDI, multi-barcode).
  final ScanMode? scanMode;

  /// Zoom factor for the camera.
  final int? zoom;

  /// Whether Digimarc decoding is enabled.
  final bool? digimarcDecoding;

  const CameraSpecific({
    this.continuousRead,
    this.beamTimer,
    this.viewfinderSize,
    this.viewfinderOffsetX,
    this.viewfinderOffsetY,
    this.linearSecurityLevel,
    this.illuminationMode,
    this.inverse1DMode,
    this.viewfinderMode,
    this.oneDQuietZoneLevel,
    this.poorQualityDecodeEffortLevel,
    this.picklistEx,
    this.aimType,
    this.aimTimer,
    this.sameSymbolTimeout,
    this.differentSymbolTimeout,
    this.characterSetSelection,
    this.autoCharacterSetFailureOption,
    this.autoCharacterSetPreferredOrder,
    this.scanMode,
    this.zoom,
    this.digimarcDecoding,
  });

  factory CameraSpecific.fromMap(Map<String, dynamic> map) {
    return CameraSpecific(
      continuousRead: map['continuousRead'] != null
          ? ContinuousRead.fromMap(Map<String, dynamic>.from(map['continuousRead']))
          : null,
      beamTimer: map['beamTimer'] as int?,
      viewfinderSize: map['viewfinderSize'] as int?,
      viewfinderOffsetX: map['viewfinderOffsetX'] as int?,
      viewfinderOffsetY: map['viewfinderOffsetY'] as int?,
      linearSecurityLevel: map['linearSecurityLevel'] != null
          ? LinearSecurityLevel.fromValue(map['linearSecurityLevel'] as String)
          : null,
      illuminationMode: map['illuminationMode'] != null
          ? IlluminationMode.fromValue(map['illuminationMode'] as String)
          : null,
      inverse1DMode: map['inverse1DMode'] != null
          ? Inverse1DMode.fromValue(map['inverse1DMode'] as String)
          : null,
      viewfinderMode: map['viewfinderMode'] != null
          ? ViewFinderMode.fromValue(map['viewfinderMode'] as String)
          : null,
      oneDQuietZoneLevel: map['oneDQuietZoneLevel'] != null
          ? OneDQuietZoneLevel.fromValue(map['oneDQuietZoneLevel'] as String)
          : null,
      poorQualityDecodeEffortLevel: map['poorQualityDecodeEffortLevel'] != null
          ? PoorQualityDecodeEffortLevel.fromValue(map['poorQualityDecodeEffortLevel'] as String)
          : null,
      picklistEx: map['picklistEx'] != null
          ? PicklistEx.fromValue(map['picklistEx'] as String)
          : null,
      aimType: map['aimType'] != null
          ? AimType.fromValue(map['aimType'] as String)
          : null,
      aimTimer: map['aimTimer'] as int?,
      sameSymbolTimeout: map['sameSymbolTimeout'] as int?,
      differentSymbolTimeout: map['differentSymbolTimeout'] as int?,
      characterSetSelection: map['characterSetSelection'] != null
          ? CharacterSet.fromValue(map['characterSetSelection'] as String)
          : null,
      autoCharacterSetFailureOption: map['autoCharacterSetFailureOption'] != null
          ? AutoCharacterSetFailureOption.fromValue(map['autoCharacterSetFailureOption'] as String)
          : null,
      autoCharacterSetPreferredOrder: map['autoCharacterSetPreferredOrder'] != null
          ? List<AutoCharacterSetPreference>.from(
              (map['autoCharacterSetPreferredOrder'] as List)
                  .map((e) => AutoCharacterSetPreference.fromValue(e as String)),
            )
          : null,
      scanMode: map['scanMode'] != null
          ? ScanMode.fromValue(map['scanMode'] as String)
          : null,
      zoom: map['zoom'] as int?,
      digimarcDecoding: map['digimarcDecoding'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'continuousRead': continuousRead?.toMap(),
      'beamTimer': beamTimer,
      'viewfinderSize': viewfinderSize,
      'viewfinderOffsetX': viewfinderOffsetX,
      'viewfinderOffsetY': viewfinderOffsetY,
      'linearSecurityLevel': linearSecurityLevel?.value,
      'illuminationMode': illuminationMode?.value,
      'inverse1DMode': inverse1DMode?.value,
      'viewfinderMode': viewfinderMode?.value,
      'oneDQuietZoneLevel': oneDQuietZoneLevel?.value,
      'poorQualityDecodeEffortLevel': poorQualityDecodeEffortLevel?.value,
      'picklistEx': picklistEx?.value,
      'aimType': aimType?.value,
      'aimTimer': aimTimer,
      'sameSymbolTimeout': sameSymbolTimeout,
      'differentSymbolTimeout': differentSymbolTimeout,
      'characterSetSelection': characterSetSelection?.value,
      'autoCharacterSetFailureOption': autoCharacterSetFailureOption?.value,
      'autoCharacterSetPreferredOrder':
          autoCharacterSetPreferredOrder?.map((e) => e.value).toList(),
      'scanMode': scanMode?.value,
      'zoom': zoom,
      'digimarcDecoding': digimarcDecoding,
    };
  }
}

// ---------------------------------------------------------------------------
// MultiBarcodeParams / NGSimulScanParams / UdiParams / OcrParams
// ---------------------------------------------------------------------------

/// Parameters for multi-barcode scanning mode.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class MultiBarcodeParams {
  /// Number of barcodes to scan in a single session.
  final int? barcodeCount;

  /// Whether to report barcodes as they are decoded rather than waiting for all.
  final bool? instantReporting;

  /// Whether to include previously decoded barcodes in the result.
  final bool? reportDecodedBarcodes;

  const MultiBarcodeParams({
    this.barcodeCount,
    this.instantReporting,
    this.reportDecodedBarcodes,
  });

  factory MultiBarcodeParams.fromMap(Map<String, dynamic> map) {
    return MultiBarcodeParams(
      barcodeCount: map['barcodeCount'] as int?,
      instantReporting: map['instantReporting'] as bool?,
      reportDecodedBarcodes: map['reportDecodedBarcodes'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'barcodeCount': barcodeCount,
      'instantReporting': instantReporting,
      'reportDecodedBarcodes': reportDecodedBarcodes,
    };
  }
}

/// NG SimulScan multi-barcode parameters (inner class).
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class NGSimulScanMultiBarcodeParams {
  /// Number of barcodes to scan simultaneously.
  final int? barcodeCount;

  /// Whether to report barcodes instantly as decoded.
  final bool? instantReporting;

  /// Whether to report previously decoded barcodes.
  final bool? reportDecodedBarcodes;

  const NGSimulScanMultiBarcodeParams({
    this.barcodeCount,
    this.instantReporting,
    this.reportDecodedBarcodes,
  });

  factory NGSimulScanMultiBarcodeParams.fromMap(Map<String, dynamic> map) {
    return NGSimulScanMultiBarcodeParams(
      barcodeCount: map['barcodeCount'] as int?,
      instantReporting: map['instantReporting'] as bool?,
      reportDecodedBarcodes: map['reportDecodedBarcodes'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'barcodeCount': barcodeCount,
      'instantReporting': instantReporting,
      'reportDecodedBarcodes': reportDecodedBarcodes,
    };
  }
}

/// NG SimulScan template parameters (inner class).
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class NGSimulScanTemplateParams {
  /// Template ID to use for NG SimulScan.
  final int? templateID;

  const NGSimulScanTemplateParams({this.templateID});

  factory NGSimulScanTemplateParams.fromMap(Map<String, dynamic> map) {
    return NGSimulScanTemplateParams(templateID: map['templateID'] as int?);
  }

  Map<String, dynamic> toMap() => {'templateID': templateID};
}

/// Parameters for NG SimulScan mode.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class NGSimulScanParams {
  /// NG SimulScan mode selection.
  final NGSimulScanMode? ngSimulScanMode;

  /// Multi-barcode parameters for NG SimulScan.
  final NGSimulScanMultiBarcodeParams? multiBarcodeParams;

  const NGSimulScanParams({
    this.ngSimulScanMode,
    this.multiBarcodeParams,
  });

  factory NGSimulScanParams.fromMap(Map<String, dynamic> map) {
    return NGSimulScanParams(
      ngSimulScanMode: map['ngSimulScanMode'] != null
          ? NGSimulScanMode.fromValue(map['ngSimulScanMode'] as String)
          : null,
      multiBarcodeParams: map['multiBarcodeParams'] != null
          ? NGSimulScanMultiBarcodeParams.fromMap(
              Map<String, dynamic>.from(map['multiBarcodeParams']))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ngSimulScanMode': ngSimulScanMode?.value,
      'multiBarcodeParams': multiBarcodeParams?.toMap(),
    };
  }
}

/// Parameters controlling UDI (Unique Device Identifier) barcode parsing.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class UdiParams {
  /// Whether GS1 UDI parsing is enabled.
  final bool? enableGS1;

  /// Whether HIBCC UDI parsing is enabled.
  final bool? enableHIBCC;

  /// Whether ICCBBA UDI parsing is enabled.
  final bool? enableICCBBA;

  const UdiParams({
    this.enableGS1,
    this.enableHIBCC,
    this.enableICCBBA,
  });

  factory UdiParams.fromMap(Map<String, dynamic> map) {
    return UdiParams(
      enableGS1: map['enableGS1'] as bool?,
      enableHIBCC: map['enableHIBCC'] as bool?,
      enableICCBBA: map['enableICCBBA'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enableGS1': enableGS1,
      'enableHIBCC': enableHIBCC,
      'enableICCBBA': enableICCBBA,
    };
  }
}

/// Parameters for OCR (Optical Character Recognition) scanning.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class OcrParams {
  /// Inverse OCR mode (regular/inverse/auto).
  final InverseOcr? inverseOcr;

  /// Number of OCR lines to read.
  final OcrLines? ocrLines;

  /// Maximum number of characters to decode.
  final int? maxCharacters;

  /// Minimum number of characters to decode.
  final int? minCharacters;

  /// Quiet zone size for OCR.
  final int? quietZone;

  /// OCR template string.
  final String? template;

  /// Orientation of the OCR text.
  final OcrOrientation? orientation;

  /// Character subset for OCR decoding.
  final String? subset;

  /// Check digit modulus value.
  final int? checkDigitModulus;

  /// Check digit multiplier string.
  final String? checkDigitMultiplier;

  /// Check digit validation method.
  final OcrCheckDigitValidation? checkDigitValidation;

  const OcrParams({
    this.inverseOcr,
    this.ocrLines,
    this.maxCharacters,
    this.minCharacters,
    this.quietZone,
    this.template,
    this.orientation,
    this.subset,
    this.checkDigitModulus,
    this.checkDigitMultiplier,
    this.checkDigitValidation,
  });

  factory OcrParams.fromMap(Map<String, dynamic> map) {
    return OcrParams(
      inverseOcr: map['inverseOcr'] != null
          ? InverseOcr.fromValue(map['inverseOcr'] as String)
          : null,
      ocrLines: map['ocrLines'] != null
          ? OcrLines.fromValue(map['ocrLines'] as String)
          : null,
      maxCharacters: map['maxCharacters'] as int?,
      minCharacters: map['minCharacters'] as int?,
      quietZone: map['quietZone'] as int?,
      template: map['template'] as String?,
      orientation: map['orientation'] != null
          ? OcrOrientation.fromValue(map['orientation'] as String)
          : null,
      subset: map['subset'] as String?,
      checkDigitModulus: map['checkDigitModulus'] as int?,
      checkDigitMultiplier: map['checkDigitMultiplier'] as String?,
      checkDigitValidation: map['checkDigitValidation'] != null
          ? OcrCheckDigitValidation.fromValue(map['checkDigitValidation'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'inverseOcr': inverseOcr?.value,
      'ocrLines': ocrLines?.value,
      'maxCharacters': maxCharacters,
      'minCharacters': minCharacters,
      'quietZone': quietZone,
      'template': template,
      'orientation': orientation?.value,
      'subset': subset,
      'checkDigitModulus': checkDigitModulus,
      'checkDigitMultiplier': checkDigitMultiplier,
      'checkDigitValidation': checkDigitValidation?.value,
    };
  }
}

/// Interface params for Bluetooth scanner connection.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
class InterfaceParams {
  /// Whether to display a Bluetooth address barcode for pairing.
  final bool? displayBluetoothAddressBarcode;

  /// Time (seconds) to wait when establishing a Bluetooth connection.
  final int? connectionEstablishTime;

  const InterfaceParams({
    this.displayBluetoothAddressBarcode,
    this.connectionEstablishTime,
  });

  factory InterfaceParams.fromMap(Map<String, dynamic> map) {
    return InterfaceParams(
      displayBluetoothAddressBarcode: map['displayBluetoothAddressBarcode'] as bool?,
      connectionEstablishTime: map['connectionEstablishTime'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayBluetoothAddressBarcode': displayBluetoothAddressBarcode,
      'connectionEstablishTime': connectionEstablishTime,
    };
  }
}

// ---------------------------------------------------------------------------
// ScannerConfig Enums
// ---------------------------------------------------------------------------

/// Determines scanner behaviour when an unsupported parameter is encountered.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum SkipOnUnSupported {
  none('NONE'),
  unsupportedParam('UNSUPPORTED_PARAM'),
  unsupportedValue('UNSUPPORTED_VALUE'),
  all('ALL');

  final String value;
  const SkipOnUnSupported(this.value);
  static SkipOnUnSupported fromValue(String value) =>
      SkipOnUnSupported.values.firstWhere((e) => e.value == value);
}

/// Code ID type prepended to decoded barcode data.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum CodeIdType {
  none('NONE'),
  aim('AIM'),
  symbol('SYMBOL');

  final String value;
  const CodeIdType(this.value);
  static CodeIdType fromValue(String value) =>
      CodeIdType.values.firstWhere((e) => e.value == value);
}

/// Audio stream used for decode beep sound.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum AudioStreamType {
  ringer('RINGER'),
  media('MEDIA'),
  alarms('ALARAMS');

  final String value;
  const AudioStreamType(this.value);
  static AudioStreamType fromValue(String value) =>
      AudioStreamType.values.firstWhere((e) => e.value == value);
}

/// LED feedback mode for remote (Bluetooth) scanners.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum DecodeLEDFeedbackMode {
  remote('REMOTE'),
  both('BOTH'),
  disable('DISABLE');

  final String value;
  const DecodeLEDFeedbackMode(this.value);
  static DecodeLEDFeedbackMode fromValue(String value) =>
      DecodeLEDFeedbackMode.values.firstWhere((e) => e.value == value);
}

/// Audio feedback mode for remote (Bluetooth) scanners.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum DecodeAudioFeedbackMode {
  remote('REMOTE'),
  both('BOTH'),
  disable('DISABLE');

  final String value;
  const DecodeAudioFeedbackMode(this.value);
  static DecodeAudioFeedbackMode fromValue(String value) =>
      DecodeAudioFeedbackMode.values.firstWhere((e) => e.value == value);
}

/// Aim type for scanner triggering behaviour.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum AimType {
  trigger('TRIGGER'),
  timedHold('TIMED_HOLD'),
  timedRelease('TIMED_RELEASE'),
  pressAndRelease('PRESS_AND_RELEASE'),
  presentation('PRESENTATION'),
  continuousRead('CONTINUOUS_READ'),
  pressAndSustain('PRESS_AND_SUSTAIN');

  final String value;
  const AimType(this.value);
  static AimType fromValue(String value) =>
      AimType.values.firstWhere((e) => e.value == value);
}

/// Controls the aiming pattern (dot/crosshair) visibility.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum AimingPattern {
  off('OFF'),
  on('ON');

  final String value;
  const AimingPattern(this.value);
  static AimingPattern fromValue(String value) =>
      AimingPattern.values.firstWhere((e) => e.value == value);
}

/// Adaptive scanning mode for laser scanners.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum AdaptiveScanning {
  enable('ENABLE'),
  disable('DISABLE');

  final String value;
  const AdaptiveScanning(this.value);
  static AdaptiveScanning fromValue(String value) =>
      AdaptiveScanning.values.firstWhere((e) => e.value == value);
}

/// Failure option when automatic character set detection fails.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum AutoCharacterSetFailureOption {
  none('NONE'),
  utf8('UTF_8'),
  iso88591('ISO_8859_1'),
  shiftJis('Shift_JIS'),
  gb18030('GB18030');

  final String value;
  const AutoCharacterSetFailureOption(this.value);
  static AutoCharacterSetFailureOption fromValue(String value) =>
      AutoCharacterSetFailureOption.values.firstWhere((e) => e.value == value);
}

/// Preferred character set for automatic detection ordering.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum AutoCharacterSetPreference {
  utf8('UTF_8'),
  gb2312('GB2312');

  final String value;
  const AutoCharacterSetPreference(this.value);
  static AutoCharacterSetPreference fromValue(String value) =>
      AutoCharacterSetPreference.values.firstWhere((e) => e.value == value);
}

/// Laser beam width setting.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum BeamWidth {
  narrow('NARROW'),
  normal('NORMAL'),
  wide('WIDE');

  final String value;
  const BeamWidth(this.value);
  static BeamWidth fromValue(String value) =>
      BeamWidth.values.firstWhere((e) => e.value == value);
}

/// Bookland (ISBN) barcode output format.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum BooklandFormat {
  isbn10('ISBN_10'),
  isbn13('ISBN_13');

  final String value;
  const BooklandFormat(this.value);
  static BooklandFormat fromValue(String value) =>
      BooklandFormat.values.firstWhere((e) => e.value == value);
}

/// Character set used to encode decoded barcode data.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum CharacterSet {
  auto('AUTO'),
  utf8('UTF_8'),
  iso88591('ISO_8859_1'),
  shiftJis('Shift_JIS'),
  gb18030('GB18030');

  final String value;
  const CharacterSet(this.value);
  static CharacterSet fromValue(String value) =>
      CharacterSet.values.firstWhere((e) => e.value == value);
}

/// Number of check digits to verify for MSI barcodes.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum CheckDigit {
  one('ONE'),
  two('TWO');

  final String value;
  const CheckDigit(this.value);
  static CheckDigit fromValue(String value) =>
      CheckDigit.values.firstWhere((e) => e.value == value);
}

/// Check digit scheme for MSI barcodes.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum CheckDigitScheme {
  mod1110('MOD_11_10'),
  mod1010('MOD_10_10');

  final String value;
  const CheckDigitScheme(this.value);
  static CheckDigitScheme fromValue(String value) =>
      CheckDigitScheme.values.firstWhere((e) => e.value == value);
}

/// Check digit type for I 2 of 5 barcodes.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum CheckDigitType {
  no('NO'),
  uss('USS'),
  opcc('OPCC');

  final String value;
  const CheckDigitType(this.value);
  static CheckDigitType fromValue(String value) =>
      CheckDigitType.values.firstWhere((e) => e.value == value);
}

/// Coupon barcode reporting mode.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum CouponReport {
  old('OLD'),
  newReport('NEW'),
  both('BOTH');

  final String value;
  const CouponReport(this.value);
  static CouponReport fromValue(String value) =>
      CouponReport.values.firstWhere((e) => e.value == value);
}

/// Inverse mode for DotCode barcodes.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum DotCodeInverse {
  disabled('DISABLED'),
  enabled('ENABLED'),
  auto('AUTO');

  final String value;
  const DotCodeInverse(this.value);
  static DotCodeInverse fromValue(String value) =>
      DotCodeInverse.values.firstWhere((e) => e.value == value);
}

/// Mirror mode for DotCode barcodes.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum DotCodeMirror {
  disabled('DISABLED'),
  enabled('ENABLED'),
  auto('AUTO');

  final String value;
  const DotCodeMirror(this.value);
  static DotCodeMirror fromValue(String value) =>
      DotCodeMirror.values.firstWhere((e) => e.value == value);
}

/// DPM (Direct Part Mark) illumination control mode.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum DpmIlluminationControl {
  direct('DIRECT'),
  indirect('INDIRECT'),
  cycle('CYCLE');

  final String value;
  const DpmIlluminationControl(this.value);
  static DpmIlluminationControl fromValue(String value) =>
      DpmIlluminationControl.values.firstWhere((e) => e.value == value);
}

/// DPM (Direct Part Mark) decoding mode.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum DpmModes {
  disabled('DISABLED'),
  mode1('MODE_1'),
  mode2('MODE_2');

  final String value;
  const DpmModes(this.value);
  static DpmModes fromValue(String value) =>
      DpmModes.values.firstWhere((e) => e.value == value);
}

/// Security level for GS1 DataBar Limited barcodes.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum GS1LimitedSecurityLevel {
  level1('LEVEL_1'),
  level2('LEVEL_2'),
  level3('LEVEL_3'),
  level4('LEVEL_4');

  final String value;
  const GS1LimitedSecurityLevel(this.value);
  static GS1LimitedSecurityLevel fromValue(String value) =>
      GS1LimitedSecurityLevel.values.firstWhere((e) => e.value == value);
}

/// Inverse mode for Grid Matrix barcodes.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum GridMatrixInverse {
  disabled('DISABLED'),
  enabled('ENABLED'),
  auto('AUTO');

  final String value;
  const GridMatrixInverse(this.value);
  static GridMatrixInverse fromValue(String value) =>
      GridMatrixInverse.values.firstWhere((e) => e.value == value);
}

/// Mirror mode for Grid Matrix barcodes.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum GridMatrixMirror {
  disabled('DISABLED'),
  enabled('ENABLED'),
  auto('AUTO');

  final String value;
  const GridMatrixMirror(this.value);
  static GridMatrixMirror fromValue(String value) =>
      GridMatrixMirror.values.firstWhere((e) => e.value == value);
}

/// Inverse mode for Han Xin barcodes.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum HanXinInverse {
  disabled('DISABLED'),
  enabled('ENABLED'),
  auto('AUTO');

  final String value;
  const HanXinInverse(this.value);
  static HanXinInverse fromValue(String value) =>
      HanXinInverse.values.firstWhere((e) => e.value == value);
}

/// Illumination (LED/torch) on or off.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum IlluminationMode {
  off('OFF'),
  on('ON');

  final String value;
  const IlluminationMode(this.value);
  static IlluminationMode fromValue(String value) =>
      IlluminationMode.values.firstWhere((e) => e.value == value);
}

/// Inverse 1D barcode decoding mode.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum Inverse1DMode {
  disabled('DISABLED'),
  enabled('ENABLED'),
  auto('AUTO');

  final String value;
  const Inverse1DMode(this.value);
  static Inverse1DMode fromValue(String value) =>
      Inverse1DMode.values.firstWhere((e) => e.value == value);
}

/// Inverse OCR reading mode.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum InverseOcr {
  regularOnly('REGULAR_ONLY'),
  inverseOnly('INVERSE_ONLY'),
  autoDiscriminate('AUTO_DISCRIMINATE');

  final String value;
  const InverseOcr(this.value);
  static InverseOcr fromValue(String value) =>
      InverseOcr.values.firstWhere((e) => e.value == value);
}

/// ISBT 128 contact mode for concatenation.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum Isbt128ContactMode {
  never('NEVER'),
  always('ALWAYS'),
  auto('AUTO');

  final String value;
  const Isbt128ContactMode(this.value);
  static Isbt128ContactMode fromValue(String value) =>
      Isbt128ContactMode.values.firstWhere((e) => e.value == value);
}

/// LCD mode for scanning off reflective LCD displays.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum LcdMode {
  disabled('DISABLED'),
  enabled('ENABLED');

  final String value;
  const LcdMode(this.value);
  static LcdMode fromValue(String value) =>
      LcdMode.values.firstWhere((e) => e.value == value);
}

/// Linear barcode security level.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum LinearSecurityLevel {
  shortOrCodabar('SHORT_OR_CODABAR'),
  allTwice('ALL_TWICE'),
  longAndShort('LONG_AND_SHORT'),
  allThrice('ALL_THRICE');

  final String value;
  const LinearSecurityLevel(this.value);
  static LinearSecurityLevel fromValue(String value) =>
      LinearSecurityLevel.values.firstWhere((e) => e.value == value);
}

/// NG SimulScan operating mode.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum NGSimulScanMode {
  none('NONE'),
  multiBarcode('MULTI_BARCODE');

  final String value;
  const NGSimulScanMode(this.value);
  static NGSimulScanMode fromValue(String value) =>
      NGSimulScanMode.values.firstWhere((e) => e.value == value);
}

/// OCR-A variant selection.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum OcrAVariant {
  fullAscii('FULL_ASCII'),
  reserved1('RESERVED_1'),
  reserved2('RESERVED_2'),
  banking('BANKING');

  final String value;
  const OcrAVariant(this.value);
  static OcrAVariant fromValue(String value) =>
      OcrAVariant.values.firstWhere((e) => e.value == value);
}

/// OCR-B variant selection.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum OcrBVariant {
  fullAscii('FULL_ASCII'),
  banking('BANKING'),
  isbn1('ISBN_1'),
  isbn2('ISBN_2'),
  travelDocument1('TRAVEL_DOCUMENT_1'),
  travelDocument2('TRAVEL_DOCUMENT_2'),
  travelDocument3('TRAVEL_DOCUMENT_3'),
  passport('PASSPORT'),
  visaTypeA('VISA_TYPE_A'),
  visaTypeB('VISA_TYPE_B'),
  icaoTravelDocument('ICAO_TRAVEL_DOCUMENT');

  final String value;
  const OcrBVariant(this.value);
  static OcrBVariant fromValue(String value) =>
      OcrBVariant.values.firstWhere((e) => e.value == value);
}

/// OCR check digit validation algorithm.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum OcrCheckDigitValidation {
  none('NONE'),
  productAddRightToLeft('PRODUCT_ADD_RIGHT_TO_LEFT'),
  digitAddRightToLeft('DIGIT_ADD_RIGHT_TO_LEFT'),
  productAddLeftToRight('PRODUCT_ADD_LEFT_TO_RIGHT'),
  digitAddLeftToRight('DIGIT_ADD_LEFT_TO_RIGHT'),
  productAddRightToLeftSimpleRemainder('PRODUCT_ADD_RIGHT_TO_LEFT_SIMPLE_REMAINDER'),
  digitAddRightToLeftSimpleRemainder('DIGIT_ADD_RIGHT_TO_LEFT_SIMPLE_REMAINDER'),
  healthIndustryHibcc43('HEALTH_INDUSTRY_HIBCC43');

  final String value;
  const OcrCheckDigitValidation(this.value);
  static OcrCheckDigitValidation fromValue(String value) =>
      OcrCheckDigitValidation.values.firstWhere((e) => e.value == value);
}

/// Number of OCR lines to read.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum OcrLines {
  oneLine('ONE_LINE'),
  twoLines('TWO_LINES'),
  threeLines('THREE_LINES');

  final String value;
  const OcrLines(this.value);
  static OcrLines fromValue(String value) =>
      OcrLines.values.firstWhere((e) => e.value == value);
}

/// OCR text orientation.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum OcrOrientation {
  degree0('DEGREE_0'),
  degree270('DEGREE_270'),
  degree180('DEGREE_180'),
  degree90('DEGREE_90'),
  omnidirectional('OMNIDIRECTIONAL');

  final String value;
  const OcrOrientation(this.value);
  static OcrOrientation fromValue(String value) =>
      OcrOrientation.values.firstWhere((e) => e.value == value);
}

/// Tolerance level for 1D barcode quiet zones.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum OneDQuietZoneLevel {
  level0('LEVEL_0'),
  level1('LEVEL_1'),
  level2('LEVEL_2'),
  level3('LEVEL_3');

  final String value;
  const OneDQuietZoneLevel(this.value);
  static OneDQuietZoneLevel fromValue(String value) =>
      OneDQuietZoneLevel.values.firstWhere((e) => e.value == value);
}

/// Whether to re-pair scanner after reboot.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum PairAfterScannerReboot {
  disable('DISABLE'),
  enable('ENABLE');

  final String value;
  const PairAfterScannerReboot(this.value);
  static PairAfterScannerReboot fromValue(String value) =>
      PairAfterScannerReboot.values.firstWhere((e) => e.value == value);
}

/// Picklist mode for imager scanners.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum PickList {
  disabled('DISABLED'),
  enabled('ENABLED');

  final String value;
  const PickList(this.value);
  static PickList fromValue(String value) =>
      PickList.values.firstWhere((e) => e.value == value);
}

/// Extended picklist mode (hardware vs software).
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum PicklistEx {
  disabled('DISABLED'),
  hardware('HARDWARE'),
  software('SOFTWARE');

  final String value;
  const PicklistEx(this.value);
  static PicklistEx fromValue(String value) =>
      PicklistEx.values.firstWhere((e) => e.value == value);
}

/// Effort level for decoding poor-quality barcodes.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum PoorQualityDecodeEffortLevel {
  level0('LEVEL_0'),
  level1('LEVEL_1'),
  level2('LEVEL_2'),
  level3('LEVEL_3');

  final String value;
  const PoorQualityDecodeEffortLevel(this.value);
  static PoorQualityDecodeEffortLevel fromValue(String value) =>
      PoorQualityDecodeEffortLevel.values.firstWhere((e) => e.value == value);
}

/// Laser power mode.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum PowerMode {
  optimized('OPTIMIZED'),
  high('HIGH'),
  alwaysOn('ALWAYS_ON');

  final String value;
  const PowerMode(this.value);
  static PowerMode fromValue(String value) =>
      PowerMode.values.firstWhere((e) => e.value == value);
}

/// Preamble characters for UPC/EAN barcodes.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum Preamble {
  none('NONE'),
  sysChar('SYS_CHAR'),
  countryAndSysChar('COUNTRY_AND_SYS_CHAR');

  final String value;
  const Preamble(this.value);
  static Preamble fromValue(String value) =>
      Preamble.values.firstWhere((e) => e.value == value);
}

/// Sensitivity of presentation mode triggering.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum PresentationModeSensitivity {
  medium('MEDIUM'),
  high('HIGH');

  final String value;
  const PresentationModeSensitivity(this.value);
  static PresentationModeSensitivity fromValue(String value) =>
      PresentationModeSensitivity.values.firstWhere((e) => e.value == value);
}

/// Scan mode (single barcode, UDI, or multi-barcode).
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum ScanMode {
  singleBarcode('SINGLE_BARCODE'),
  udi('UDI'),
  multiBarcode('MULTI_BARCODE');

  final String value;
  const ScanMode(this.value);
  static ScanMode fromValue(String value) =>
      ScanMode.values.firstWhere((e) => e.value == value);
}

/// Scene detection qualifier for smarter presentation triggering.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum SceneDetectionQualifier {
  none('NONE'),
  proximitySensorInput('PROXIMITY_SENSOR_INPUT');

  final String value;
  const SceneDetectionQualifier(this.value);
  static SceneDetectionQualifier fromValue(String value) =>
      SceneDetectionQualifier.values.firstWhere((e) => e.value == value);
}

/// Barcode security level for duplicate symbol rejection.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum SecurityLevel {
  level0('LEVEL_0'),
  level1('LEVEL_1'),
  level2('LEVEL_2'),
  level3('LEVEL_3');

  final String value;
  const SecurityLevel(this.value);
  static SecurityLevel fromValue(String value) =>
      SecurityLevel.values.firstWhere((e) => e.value == value);
}

/// Bits per pixel for Signature capture images.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum SignatureImageBitsPerPixel {
  bpp1('BPP_1'),
  bpp4('BPP_4'),
  bpp8('BPP_8');

  final String value;
  const SignatureImageBitsPerPixel(this.value);
  static SignatureImageBitsPerPixel fromValue(String value) =>
      SignatureImageBitsPerPixel.values.firstWhere((e) => e.value == value);
}

/// Image format for Signature capture output.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum SignatureImageFormat {
  jpeg('JPEG'),
  bmp('BMP'),
  tiff('TIFF');

  final String value;
  const SignatureImageFormat(this.value);
  static SignatureImageFormat fromValue(String value) =>
      SignatureImageFormat.values.firstWhere((e) => e.value == value);
}

/// Supplemental barcode reading mode (UPC/EAN add-ons).
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum SupplementalMode {
  no('NO'),
  always('ALWAYS'),
  auto('AUTO'),
  smart('SMART'),
  s378379('S_378_379'),
  s978979('S_978_979'),
  s414419434439('S_414_419_434_439'),
  s977('S_977');

  final String value;
  const SupplementalMode(this.value);
  static SupplementalMode fromValue(String value) =>
      SupplementalMode.values.firstWhere((e) => e.value == value);
}

/// UCC/EAN 128 composite link mode.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum UccLinkMode {
  alwaysLinked('ALWAYS_LINKED'),
  autoDiscriminate('AUTO_DISCRIMINATE');

  final String value;
  const UccLinkMode(this.value);
  static UccLinkMode fromValue(String value) =>
      UccLinkMode.values.firstWhere((e) => e.value == value);
}

/// Verify check digit strictness for Code 11.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum VerifyCheckDigit {
  no('NO'),
  one('ONE'),
  two('TWO');

  final String value;
  const VerifyCheckDigit(this.value);
  static VerifyCheckDigit fromValue(String value) =>
      VerifyCheckDigit.values.firstWhere((e) => e.value == value);
}

/// Viewfinder display mode for camera scanners.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerConfig/
enum ViewFinderMode {
  enabled('ENABLED'),
  staticReticle('STATIC_RECTICLE');

  final String value;
  const ViewFinderMode(this.value);
  static ViewFinderMode fromValue(String value) =>
      ViewFinderMode.values.firstWhere((e) => e.value == value);
}