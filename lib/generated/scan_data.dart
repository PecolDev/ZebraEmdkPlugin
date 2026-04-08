// ================= FILE: scan_data.dart =================

// ignore_for_file: constant_identifier_names

import 'dart:typed_data';

/// Result codes returned by scanner operations.
///
/// Indicates the success or failure reason of a scan session.
///
/// See: https://techdocs.zebra.com/emdk-for-android/13-0/api/reference/com/symbol/emdk/barcode/scannerresults
enum ScannerResults {
  /// The operation completed successfully.
  success('SUCCESS'),

  /// An unspecified failure occurred.
  failure('FAILURE'),

  /// The scanner is already in the process of scanning.
  alreadyScanning('ALREADY_SCANNING'),

  /// An error occurred while parsing data from the scanner.
  dataParsingFailure('DATA_PARSING_FAILURE'),

  /// The requested feature is not supported by this scanner.
  featureNotSupported('FEATURE_NOT_SUPPORTED'),

  /// The scanner object is invalid or has been released.
  invalidObject('INVALID_OBJECT'),

  /// An invalid value was provided to a scanner parameter.
  invalidValue('INVALID_VALUE'),

  /// A length mismatch was detected in the scanner configuration.
  lengthMismatch('LENGTH_MISMATCH'),

  /// No data listener was registered before calling read.
  noDataListener('NO_DATA_LISTENER'),

  /// An error occurred while collecting scan data.
  scanDataFailure('SCAN_DATA_FAILURE'),

  /// A scanner parameter is not supported by this device.
  scanParamNotSupported('SCAN_PARAM_NOT_SUPPORTED'),

  /// A scanner parameter is read-only and cannot be changed.
  scanParamReadOnly('SCAN_PARAM_READ_ONLY'),

  /// The scanner failed to de-initialise.
  scannerDeinitFailure('SCANNER_DEINIT_FAILURE'),

  /// The scanner is currently in use by another application.
  scannerInUse('SCANNER_IN_USE'),

  /// The scanner failed to initialise.
  scannerInitFailure('SCANNER_INIT_FAILURE'),

  /// The scanner is not connected.
  scannerNotConnected('SCANNER_NOT_CONNECTED'),

  /// The scanner is not enabled.
  scannerNotEnabled('SCANNER_NOT_ENABLED'),

  /// The scanner type is not supported on this device.
  scannerNotSupported('SCANNER_NOT_SUPPORTED'),

  /// A generic scanner operation failure occurred.
  scannerOperationFailure('SCANNER_OPERATION_FAILURE'),

  /// The scanner operation timed out.
  scannerTimedOut('SCANNER_TIMED_OUT'),

  /// The trigger key is already in use by another component.
  triggerKeyInUse('TRIGGER_KEY_IN_USE'),

  /// Failed to register the trigger key.
  triggerKeyRegFailed('TRIGGER_KEY_REG_FAILED'),

  /// Failed to unregister the trigger key.
  triggerKeyUnregFailed('TRIGGER_KEY_UNREG_FAILED'),

  /// The result code is undefined or unknown.
  undefined('UNDEFINED'),

  /// The requested feature requires a license that is not present.
  unlicensedFeature('UNLICENSED_FEATURE'),

  /// A video-frame error occurred during scanning.
  vfError('VF_ERROR');

  /// The string value used when serialising/deserialising over the platform channel.
  final String value;

  const ScannerResults(this.value);

  /// Returns the [ScannerResults] whose [value] matches [value].
  ///
  /// Falls back to [ScannerResults.undefined] if no match is found.
  static ScannerResults fromValue(String value) =>
      ScannerResults.values.firstWhere((e) => e.value == value,
          orElse: () => ScannerResults.undefined);
}

// ---------------------------------------------------------------------------
// LabelType
// ---------------------------------------------------------------------------

/// Identifies the barcode symbology of a decoded scan result.
///
/// Returned by [ScanData.labelType] to indicate what kind of barcode was read.
///
/// See: https://techdocs.zebra.com/emdk-for-android/13-0/api/reference/com/symbol/emdk/barcode/scandatacollection.labeltype
enum LabelType {
  /// Australian Postal barcode.
  auspostal('AUSPOSTAL'),

  /// Aztec 2D barcode.
  aztec('AZTEC'),

  /// EAN-13 Bookland barcode (ISBN).
  bookland('BOOKLAND'),

  /// Canadian Postal barcode.
  canpostal('CANPOSTAL'),

  /// Chinese 2 of 5 barcode.
  chinese2of5('CHINESE_2OF5'),

  /// Codabar barcode.
  codabar('CODABAR'),

  /// Code 11 barcode.
  code11('CODE11'),

  /// Code 128 barcode.
  code128('CODE128'),

  /// Code 32 (Italian Pharmacode) barcode.
  code32('CODE32'),

  /// Code 39 barcode.
  code39('CODE39'),

  /// Code 93 barcode.
  code93('CODE93'),

  /// GS1 Composite AB barcode.
  compositeAb('COMPOSITE_AB'),

  /// GS1 Composite C barcode.
  compositeC('COMPOSITE_C'),

  /// Coupon barcode.
  coupon('COUPON'),

  /// Discrete 2 of 5 barcode.
  d2of5('D2OF5'),

  /// GS1 DataBar Coupon barcode.
  databarCoupon('DATABAR_COUPON'),

  /// Data Matrix 2D barcode.
  datamatrix('DATAMATRIX'),

  /// DotCode barcode.
  dotcode('DOTCODE'),

  /// Dutch Postal barcode.
  dutchpostal('DUTCHPOSTAL'),

  /// EAN 128 / GS1-128 barcode.
  ean128('EAN128'),

  /// EAN-13 barcode.
  ean13('EAN13'),

  /// EAN-8 barcode.
  ean8('EAN8'),

  /// Finnish Postal 4S barcode.
  finnishpostal4s('FINNISHPOSTAL_4S'),

  /// Grid Matrix 2D barcode.
  gridmatrix('GRIDMATRIX'),

  /// GS1 DataBar (RSS-14) barcode.
  gs1Databar('GS1_DATABAR'),

  /// GS1 DataBar Expanded barcode.
  gs1DatabarExp('GS1_DATABAR_EXP'),

  /// GS1 DataBar Limited barcode.
  gs1DatabarLim('GS1_DATABAR_LIM'),

  /// GS1 DataMatrix 2D barcode.
  gs1Datamatrix('GS1_DATAMATRIX'),

  /// GS1 QR Code barcode.
  gs1Qrcode('GS1_QRCODE'),

  /// Han Xin 2D barcode.
  hanxin('HANXIN'),

  /// Interleaved 2 of 5 barcode.
  i2of5('I2OF5'),

  /// IATA 2 of 5 barcode.
  iata2of5('IATA2OF5'),

  /// ISBT 128 barcode.
  isbt128('ISBT128'),

  /// Japanese Postal barcode.
  jappostal('JAPPOSTAL'),

  /// Korean 3 of 5 barcode.
  korean3of5('KOREAN_3OF5'),

  /// Royal Mail Mailmark barcode.
  mailmark('MAILMARK'),

  /// Matrix 2 of 5 barcode.
  matrix2of5('MATRIX_2OF5'),

  /// MaxiCode barcode.
  maxicode('MAXICODE'),

  /// Micro PDF 417 barcode.
  micropdf('MICROPDF'),

  /// Micro QR Code barcode.
  microqr('MICROQR'),

  /// MSI Plessey barcode.
  msi('MSI'),

  /// OCR (Optical Character Recognition) result.
  ocr('OCR'),

  /// PDF417 2D barcode.
  pdf417('PDF417'),

  /// QR Code 2D barcode.
  qrcode('QRCODE'),

  /// Signature capture result.
  signature('SIGNATURE'),

  /// TLC39 barcode (combines Code 39 and Micro PDF).
  tlc39('TLC39'),

  /// TriOptic 39 barcode.
  trioptic39('TRIOPTIC39'),

  /// UK Postal barcode.
  ukpostal('UKPOSTAL'),

  /// Symbology is undefined or unknown.
  undefined('UNDEFINED'),

  /// UPC-A barcode.
  upca('UPCA'),

  /// UPC-E0 barcode.
  upce0('UPCE0'),

  /// UPC-E1 barcode.
  upce1('UPCE1'),

  /// US 4-State barcode.
  us4state('US4STATE'),

  /// US 4-State FICS barcode.
  us4stateFics('US4STATE_FICS'),

  /// US Planet barcode.
  usplanet('USPLANET'),

  /// US PostNet barcode.
  uspostnet('USPOSTNET'),

  /// Web Code barcode.
  webcode('WEBCODE');

  /// The string value used when serialising/deserialising over the platform channel.
  final String value;

  const LabelType(this.value);

  /// Returns the [LabelType] whose [value] matches [value].
  ///
  /// Falls back to [LabelType.undefined] if no match is found.
  static LabelType fromValue(String value) =>
      LabelType.values.firstWhere((e) => e.value == value,
          orElse: () => LabelType.undefined);
}

// ---------------------------------------------------------------------------
// ScanData
// ---------------------------------------------------------------------------

/// Represents a single decoded barcode within a [ScanDataCollection].
///
/// Each element in [ScanDataCollection.scanData] is a [ScanData] instance
/// containing the decoded string, its symbology, the raw bytes, and the
/// timestamp at which the label was scanned.
///
/// See: https://techdocs.zebra.com/emdk-for-android/13-0/api/reference/com/symbol/emdk/barcode/scandatacollection.scandata
class ScanData {
  /// The decoded barcode data as a string.
  ///
  /// Returns an empty string if an error occurred.
  final String? data;

  /// The raw decoded barcode bytes.
  ///
  /// The application can use this to convert to a specific charset if needed.
  final Uint8List? rawData;

  /// The symbology of the decoded barcode.
  final LabelType? labelType;

  /// The time at which the barcode was scanned.
  ///
  /// Format: `"yyyy-MM-dd HH:mm:ss.nnnnnnnnn"`
  final String? timeStamp;

  const ScanData({
    this.data,
    this.rawData,
    this.labelType,
    this.timeStamp,
  });

  /// Creates a [ScanData] from a [Map] received via the platform channel.
  factory ScanData.fromMap(Map<String, dynamic> map) {
    return ScanData(
      data: map['data'] as String?,
      rawData: map['rawData'] as Uint8List?,
      labelType: map['labelType'] != null
          ? LabelType.fromValue(map['labelType'] as String)
          : null,
      timeStamp: map['timeStamp'] as String?,
    );
  }

  /// Converts this [ScanData] to a [Map] suitable for sending over the platform channel.
  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'rawData': rawData,
      'labelType': labelType?.value,
      'timeStamp': timeStamp,
    };
  }
}

// ---------------------------------------------------------------------------
// Token
// ---------------------------------------------------------------------------

/// A single token extracted from UDI or other structured barcode data.
///
/// Tokens are produced when the scanner parses a structured symbology
/// (e.g. UDI) into labelled key/value pairs.
///
/// See: https://techdocs.zebra.com/emdk-for-android/13-0/api/reference/com/symbol/emdk/barcode/tokenizeddata.token
class Token {
  /// The decoded string value for this token.
  final String? data;

  /// The data type of this token's value (e.g. `"string"`, `"date"`).
  final String? dataType;

  /// The format description of this token.
  final String? format;

  /// The key (field name) that identifies this token in the structured data.
  final String? key;

  /// The raw byte representation of the token data.
  final Uint8List? rawData;

  const Token({
    this.data,
    this.dataType,
    this.format,
    this.key,
    this.rawData,
  });

  /// Creates a [Token] from a [Map] received via the platform channel.
  factory Token.fromMap(Map<String, dynamic> map) {
    return Token(
      data: map['data'] as String?,
      dataType: map['dataType'] as String?,
      format: map['format'] as String?,
      key: map['key'] as String?,
      rawData: map['rawData'] as Uint8List?,
    );
  }

  /// Converts this [Token] to a [Map] suitable for sending over the platform channel.
  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'dataType': dataType,
      'format': format,
      'key': key,
      'rawData': rawData,
    };
  }
}

// ---------------------------------------------------------------------------
// TokenizedData
// ---------------------------------------------------------------------------

/// Contains the structured (tokenized) data parsed from a barcode scan.
///
/// When a scanner reads a structured symbology such as a UDI barcode, the
/// raw data is parsed into a list of [Token] objects, each representing a
/// named field within the barcode.
///
/// See: https://techdocs.zebra.com/emdk-for-android/13-0/api/reference/com/symbol/emdk/barcode/tokenizeddata
class TokenizedData {
  /// All tokens extracted from the decoded barcode data.
  final List<Token>? tokens;

  const TokenizedData({this.tokens});

  /// Creates a [TokenizedData] from a [Map] received via the platform channel.
  factory TokenizedData.fromMap(Map<String, dynamic> map) {
    return TokenizedData(
      tokens: map['tokens'] != null
          ? List<Token>.from(
              (map['tokens'] as List)
                  .map((e) => Token.fromMap(Map<String, dynamic>.from(e))),
            )
          : null,
    );
  }

  /// Converts this [TokenizedData] to a [Map] suitable for sending over the platform channel.
  Map<String, dynamic> toMap() {
    return {
      'tokens': tokens?.map((e) => e.toMap()).toList(),
    };
  }
}

// ---------------------------------------------------------------------------
// ScanDataCollection
// ---------------------------------------------------------------------------

/// Represents the full result of a single scan session.
///
/// Passed to [Scanner.DataListener.onData] after every successful or
/// unsuccessful scan attempt. Contains the decoded barcode list, the overall
/// operation result code, and any tokenized (structured) data.
///
/// See: https://techdocs.zebra.com/emdk-for-android/13-0/api/reference/com/symbol/emdk/barcode/ScanDataCollection/
class ScanDataCollection {
  /// The human-readable name of the scanner that produced this data.
  final String? friendlyName;

  /// The label identifier for the overall scan attempt.
  ///
  /// Applicable for UDI decoding. Use [ScanData.labelType] on individual
  /// items for per-barcode symbology information.
  final String? labelIdentifier;

  /// The overall result of the scan session.
  final ScannerResults? result;

  /// The list of decoded barcodes from this scan session.
  ///
  /// In standard single-barcode mode this list contains one entry.
  /// In multi-barcode or UDI mode it may contain multiple entries.
  final List<ScanData>? scanData;

  /// Structured (tokenized) data parsed from the scan result.
  ///
  /// Non-null only when a structured symbology such as UDI was decoded.
  final TokenizedData? tokenizedData;

  const ScanDataCollection({
    this.friendlyName,
    this.labelIdentifier,
    this.result,
    this.scanData,
    this.tokenizedData,
  });

  /// Creates a [ScanDataCollection] from a [Map] received via the platform channel.
  factory ScanDataCollection.fromMap(Map<String, dynamic> map) {
    return ScanDataCollection(
      friendlyName: map['friendlyName'] as String?,
      labelIdentifier: map['labelIdentifier'] as String?,
      result: map['scannerResult'] != null
          ? ScannerResults.fromValue(map['scannerResult'] as String)
          : null,
      scanData: map['scanData'] != null
          ? List<ScanData>.from(
              (map['scanData'] as List)
                  .map((e) => ScanData.fromMap(Map<String, dynamic>.from(e))),
            )
          : null,
      tokenizedData: map['tokenizedData'] != null
          ? TokenizedData.fromMap(
              Map<String, dynamic>.from(map['tokenizedData']))
          : null,
    );
  }

  /// Converts this [ScanDataCollection] to a [Map] suitable for sending over the platform channel.
  Map<String, dynamic> toMap() {
    return {
      'friendlyName': friendlyName,
      'labelIdentifier': labelIdentifier,
      'scannerResult': result?.value,
      'scanData': scanData?.map((e) => e.toMap()).toList(),
      'tokenizedData': tokenizedData?.toMap(),
    };
  }
}

// ---------------------------------------------------------------------------
// ScannerException
// ---------------------------------------------------------------------------

/// Exception thrown by scanner operations when a barcode-related error occurs.
///
/// Catch this in any scanner call (e.g. `enable()`, `read()`) to determine the
/// specific [ScannerResults] reason for the failure.
///
/// See: https://techdocs.zebra.com/emdk-for-android/13-0/api/reference/com/symbol/emdk/barcode/ScannerException
class ScannerException implements Exception {
  /// The specific result code describing why the exception was thrown.
  final ScannerResults result;

  /// Optional human-readable message accompanying the exception.
  final String? message;

  const ScannerException(this.result, [this.message]);

  /// Creates a [ScannerException] from a [Map] received via the platform channel.
  factory ScannerException.fromMap(Map<String, dynamic> map) {
    return ScannerException(
      map['result'] != null
          ? ScannerResults.fromValue(map['result'] as String)
          : ScannerResults.undefined,
      map['message'] as String?,
    );
  }

  /// Converts this [ScannerException] to a [Map] suitable for sending over the platform channel.
  Map<String, dynamic> toMap() {
    return {
      'result': result.value,
      'message': message,
    };
  }

  @override
  String toString() =>
      'ScannerException(${result.value}${message != null ? ': $message' : ''})';
}
