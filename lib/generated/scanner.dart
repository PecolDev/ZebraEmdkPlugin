// ================= FILE: scanner.dart =================

/// Represents a physical or virtual barcode scanner device.
///
/// Provides access to scanner configuration, read operations, and
/// listener registration for data and status events.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/Scanner/
class ScannerInfo {
  /// Whether this is the default scanner on the device.
  final bool? isDefaultScanner;

  /// The human-readable name of the scanner.
  final String? friendlyName;

  /// The model number of the scanner hardware.
  final String? modelNumber;

  /// The type of scanner device (camera, imager, laser).
  final ScannerDeviceType? deviceType;

  /// The connection type of the scanner.
  final ScannerConnectionType? connectionType;

  /// The device identifier used to open this scanner.
  final BarcodeManagerDeviceIdentifier? deviceIdentifier;

  /// The decoder type supported by this scanner.
  final ScannerDecoderType? decoderType;

  /// Whether the scanner is currently connected.
  final bool? isConnected;

  const ScannerInfo({
    this.isDefaultScanner,
    this.friendlyName,
    this.modelNumber,
    this.deviceType,
    this.connectionType,
    this.deviceIdentifier,
    this.decoderType,
    this.isConnected,
  });

  factory ScannerInfo.fromMap(Map<String, dynamic> map) {
    return ScannerInfo(
      isDefaultScanner: map['isDefaultScanner'] as bool?,
      friendlyName: map['friendlyName'] as String?,
      modelNumber: map['modelNumber'] as String?,
      deviceType: map['deviceType'] != null
          ? ScannerDeviceType.fromValue(map['deviceType'] as String)
          : null,
      connectionType: map['connectionType'] != null
          ? ScannerConnectionType.fromValue(map['connectionType'] as String)
          : null,
      deviceIdentifier: map['deviceIdentifier'] != null
          ? BarcodeManagerDeviceIdentifier.fromValue(map['deviceIdentifier'] as String)
          : null,
      decoderType: map['decoderType'] != null
          ? ScannerDecoderType.fromValue(map['decoderType'] as String)
          : null,
      isConnected: map['isConnected'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isDefaultScanner': isDefaultScanner,
      'friendlyName': friendlyName,
      'modelNumber': modelNumber,
      'deviceType': deviceType?.value,
      'connectionType': connectionType?.value,
      'deviceIdentifier': deviceIdentifier?.value,
      'decoderType': decoderType?.value,
      'isConnected': isConnected,
    };
  }
}

/// Represents the current status of a scanner.
///
/// Passed to the StatusListener when the scanner state changes.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/StatusData/
class StatusData {
  /// The current state of the scanner.
  final ScannerStates? state;

  /// The human-readable name of the scanner.
  final String? friendlyName;

  const StatusData({
    this.state,
    this.friendlyName,
  });

  factory StatusData.fromMap(Map<String, dynamic> map) {
    return StatusData(
      state: map['state'] != null
          ? ScannerStates.fromValue(map['state'] as String)
          : null,
      friendlyName: map['friendlyName'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'state': state?.value,
      'friendlyName': friendlyName,
    };
  }
}

/// Enumerates the possible trigger modes for a scanner.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/Scanner/
enum ScannerTriggerType {
  /// Hardware (physical) trigger button.
  hard('HARD'),

  /// Software trigger; fires once.
  softOnce('SOFT_ONCE'),

  /// Software trigger; fires continuously.
  softAlways('SOFT_ALWAYS');

  final String value;

  const ScannerTriggerType(this.value);

  static ScannerTriggerType fromValue(String value) =>
      ScannerTriggerType.values.firstWhere((e) => e.value == value);
}

/// Current operational state of the scanner hardware.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/StatusData/
enum ScannerStates {
  /// Scanner is idle, waiting for a trigger.
  idle('IDLE'),

  /// Scanner is waiting for a scan to complete.
  waiting('WAITING'),

  /// Scanner is actively scanning.
  scanning('SCANNING'),

  /// Scanner is disabled.
  disabled('DISABLED'),

  /// Scanner encountered an error.
  error('ERROR');

  final String value;

  const ScannerStates(this.value);

  static ScannerStates fromValue(String value) =>
      ScannerStates.values.firstWhere((e) => e.value == value,
          orElse: () => ScannerStates.error);
}

/// Physical type of the scanner device.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerInfo/
enum ScannerDeviceType {
  camera('CAMERA'),
  imager('IMAGER'),
  laser('LASER'),
  undefined('UNDEFINED');

  final String value;

  const ScannerDeviceType(this.value);

  static ScannerDeviceType fromValue(String value) =>
      ScannerDeviceType.values.firstWhere((e) => e.value == value,
          orElse: () => ScannerDeviceType.undefined);
}

/// Connection type of the scanner device.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerInfo/
enum ScannerConnectionType {
  internal('INTERNAL'),
  bluetoothSsi('BLUETOOTH_SSI'),
  serialSsi('SERIAL_SSI'),
  usb('USB'),
  pluggableSsi('PLUGGABLE_SSI'),
  undefined('UNDEFINED');

  final String value;

  const ScannerConnectionType(this.value);

  static ScannerConnectionType fromValue(String value) =>
      ScannerConnectionType.values.firstWhere((e) => e.value == value,
          orElse: () => ScannerConnectionType.undefined);
}

/// Indicates the type of barcodes a scanner can decode.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/ScannerInfo/
enum ScannerDecoderType {
  oneDimensional('ONE_DIMENSIONAL'),
  twoDimensional('TWO_DIMENSIONAL'),
  undefined('UNDEFINED');

  final String value;

  const ScannerDecoderType(this.value);

  static ScannerDecoderType fromValue(String value) =>
      ScannerDecoderType.values.firstWhere((e) => e.value == value,
          orElse: () => ScannerDecoderType.undefined);
}

/// Identifies specific scanner hardware devices.
///
/// Used when requesting a specific scanner from [BarcodeManager].
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/BarcodeManager/
enum BarcodeManagerDeviceIdentifier {
  defaultDevice('DEFAULT'),
  internalCamera1('INTERNAL_CAMERA1'),
  internalImager1('INTERNAL_IMAGER1'),
  internalLaser1('INTERNAL_LASER1'),
  bluetoothImager1('BLUETOOTH_IMAGER1'),
  pluggableLaser1('PLUGGABLE_LASER1'),
  bluetoothImagerRs6000('BLUETOOTH_IMAGER_RS6000'),
  pluggableImagerRs5000('PLUGGABLE_IMAGER_RS5000'),
  bluetoothImagerDs3678('BLUETOOTH_IMAGER_DS3678'),
  pluggableImagerDs3608('PLUGGABLE_IMAGER_DS3608'),
  bluetoothLaserLi3678('BLUETOOTH_LASER_LI3678'),
  pluggableLaserLi3608('PLUGGABLE_LASER_LI3608'),
  bluetoothImagerDs2278('BLUETOOTH_IMAGER_DS2278'),
  bluetoothImagerDs8178('BLUETOOTH_IMAGER_DS8178'),
  bluetoothImagerRs5100('BLUETOOTH_IMAGER_RS5100'),
  undefined('UNDEFINED');

  final String value;

  const BarcodeManagerDeviceIdentifier(this.value);

  static BarcodeManagerDeviceIdentifier fromValue(String value) =>
      BarcodeManagerDeviceIdentifier.values.firstWhere((e) => e.value == value,
          orElse: () => BarcodeManagerDeviceIdentifier.undefined);
}

/// Connection state of an external scanner (e.g. Bluetooth).
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/barcode/BarcodeManager/
enum BarcodeManagerConnectionState {
  connected('CONNECTED'),
  disconnected('DISCONNECTED');

  final String value;

  const BarcodeManagerConnectionState(this.value);

  static BarcodeManagerConnectionState fromValue(String value) =>
      BarcodeManagerConnectionState.values.firstWhere((e) => e.value == value);
}