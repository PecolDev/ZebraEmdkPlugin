// ================= FILE: notification.dart =================

/// Notification device types.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/notification/DeviceType/
enum NotificationDeviceType {
  undefined('UNDEFINED'),
  imager('IMAGER'),
  vibrator('VIBRATOR');

  final String value;

  const NotificationDeviceType(this.value);

  static NotificationDeviceType fromValue(String value) =>
      NotificationDeviceType.values.firstWhere((e) => e.value == value,
          orElse: () => NotificationDeviceType.undefined);
}

/// Connection type for notification devices.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/notification/ConnectionType/
enum NotificationConnectionType {
  undefined('UNDEFINED'),
  bluetoothSsi('BLUETOOTH_SSI'),
  pluggable('PLUGGABLE');

  final String value;

  const NotificationConnectionType(this.value);

  static NotificationConnectionType fromValue(String value) =>
      NotificationConnectionType.values.firstWhere((e) => e.value == value,
          orElse: () => NotificationConnectionType.undefined);
}

/// Identifies specific notification devices.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/notification/NotificationManager/
enum NotificationDeviceIdentifier {
  defaultDevice('DEFAULT'),
  bluetoothImagerRs6000('BLUETOOTH_IMAGER_RS6000'),
  externalVibrator1('EXTERNAL_VIBRATOR1'),
  bluetoothImagerRs5100('BLUETOOTH_IMAGER_RS5100'),
  bluetoothGeneric('BLUETOOTH_GENERIC');

  final String value;

  const NotificationDeviceIdentifier(this.value);

  static NotificationDeviceIdentifier fromValue(String value) =>
      NotificationDeviceIdentifier.values.firstWhere((e) => e.value == value);
}

/// Result codes for notification operations.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/notification/NotificationResults/
enum NotificationResults {
  success('SUCCESS'),
  deviceNotConnected('DEVICE_NOT_CONNECTED'),
  deviceInvalid('DEVICE_INVALID'),
  deviceNotEnabled('DEVICE_NOT_ENABLED'),
  deviceAlreadyEnabled('DEVICE_ALREADY_ENABLED'),
  failure('FAILURE'),
  invalidValue('INVALID_VALUE'),
  featureNotSupported('FEATURE_NOT_SUPPORTED'),
  commandNotSupported('COMMAND_NOT_SUPPORTED'),
  undefined('UNDEFINED');

  final String value;

  const NotificationResults(this.value);

  static NotificationResults fromValue(String value) =>
      NotificationResults.values.firstWhere((e) => e.value == value,
          orElse: () => NotificationResults.undefined);
}

/// Represents info about a connected notification device (e.g. RS6000).
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/notification/DeviceInfo/
class NotificationDeviceInfo {
  /// Human-readable device name.
  final String? friendlyName;

  /// Device model number.
  final String? modelNumber;

  /// Device type.
  final NotificationDeviceType? deviceType;

  /// Connection type.
  final NotificationConnectionType? connectionType;

  /// Device identifier.
  final NotificationDeviceIdentifier? deviceIdentifier;

  /// Whether this is the default notification device.
  final bool? isDefaultDevice;

  /// Whether the device is currently connected.
  final bool? isConnected;

  /// Whether LED notification is supported.
  final bool? isLEDSupported;

  /// Whether beep notification is supported.
  final bool? isBeepSupported;

  /// Whether vibrate notification is supported.
  final bool? isVibrateSupported;

  const NotificationDeviceInfo({
    this.friendlyName,
    this.modelNumber,
    this.deviceType,
    this.connectionType,
    this.deviceIdentifier,
    this.isDefaultDevice,
    this.isConnected,
    this.isLEDSupported,
    this.isBeepSupported,
    this.isVibrateSupported,
  });

  factory NotificationDeviceInfo.fromMap(Map<String, dynamic> map) {
    return NotificationDeviceInfo(
      friendlyName: map['friendlyName'] as String?,
      modelNumber: map['modelNumber'] as String?,
      deviceType: map['deviceType'] != null
          ? NotificationDeviceType.fromValue(map['deviceType'] as String)
          : null,
      connectionType: map['connectionType'] != null
          ? NotificationConnectionType.fromValue(map['connectionType'] as String)
          : null,
      deviceIdentifier: map['deviceIdentifier'] != null
          ? NotificationDeviceIdentifier.fromValue(map['deviceIdentifier'] as String)
          : null,
      isDefaultDevice: map['isDefaultDevice'] as bool?,
      isConnected: map['isConnected'] as bool?,
      isLEDSupported: map['isLEDSupported'] as bool?,
      isBeepSupported: map['isBeepSupported'] as bool?,
      isVibrateSupported: map['isVibrateSupported'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'friendlyName': friendlyName,
      'modelNumber': modelNumber,
      'deviceType': deviceType?.value,
      'connectionType': connectionType?.value,
      'deviceIdentifier': deviceIdentifier?.value,
      'isDefaultDevice': isDefaultDevice,
      'isConnected': isConnected,
      'isLEDSupported': isLEDSupported,
      'isBeepSupported': isBeepSupported,
      'isVibrateSupported': isVibrateSupported,
    };
  }
}

/// A single beep tone (frequency + duration).
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/notification/Notification/
class NotificationBeep {
  /// Duration of the beep in milliseconds.
  final int? time;

  /// Frequency of the beep in Hz.
  final int? frequency;

  const NotificationBeep({this.time, this.frequency});

  factory NotificationBeep.fromMap(Map<String, dynamic> map) {
    return NotificationBeep(
      time: map['time'] as int?,
      frequency: map['frequency'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {'time': time, 'frequency': frequency};
  }
}

/// A sequence of beep tones to play.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/notification/Notification/
class NotificationBeepParams {
  /// Ordered list of beep tones in the pattern.
  final List<NotificationBeep>? pattern;

  const NotificationBeepParams({this.pattern});

  factory NotificationBeepParams.fromMap(Map<String, dynamic> map) {
    return NotificationBeepParams(
      pattern: map['pattern'] != null
          ? List<NotificationBeep>.from(
              List<Map<String, dynamic>>.from(map['pattern'])
                  .map((e) => NotificationBeep.fromMap(e)),
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {'pattern': pattern?.map((e) => e.toMap()).toList()};
  }
}

/// LED notification parameters.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/notification/Notification/
class NotificationLEDParams {
  /// Constant for infinite repeat.
  static const int repeatInfinite = -1;

  /// LED color as an Android Color integer.
  final int? color;

  /// On-time of the LED blink in milliseconds.
  final int? onTime;

  /// Off-time of the LED blink in milliseconds.
  final int? offTime;

  /// Number of times to repeat; use [repeatInfinite] for continuous.
  final int? repeatCount;

  const NotificationLEDParams({
    this.color,
    this.onTime,
    this.offTime,
    this.repeatCount,
  });

  factory NotificationLEDParams.fromMap(Map<String, dynamic> map) {
    return NotificationLEDParams(
      color: map['color'] as int?,
      onTime: map['onTime'] as int?,
      offTime: map['offTime'] as int?,
      repeatCount: map['repeatCount'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'color': color,
      'onTime': onTime,
      'offTime': offTime,
      'repeatCount': repeatCount,
    };
  }
}

/// Vibration notification parameters.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/notification/Notification/
class NotificationVibrateParams {
  /// Vibration duration in milliseconds.
  final int? time;

  /// Vibration pattern as a list of on/off durations in milliseconds.
  final List<int>? pattern;

  const NotificationVibrateParams({this.time, this.pattern});

  factory NotificationVibrateParams.fromMap(Map<String, dynamic> map) {
    return NotificationVibrateParams(
      time: map['time'] as int?,
      pattern: map['pattern'] != null
          ? List<int>.from(map['pattern'] as List)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {'time': time, 'pattern': pattern};
  }
}

/// Notification command sent to a notification device.
///
/// Combines LED, beep, and vibration parameters into one object.
///
/// See: https://techdocs.zebra.com/emdk-for-android/latest/api/reference/com/symbol/emdk/notification/Notification/
class NotificationCommand {
  /// LED parameters; null if LED notification is not desired.
  final NotificationLEDParams? led;

  /// Beep parameters; null if audio notification is not desired.
  final NotificationBeepParams? beep;

  /// Vibration parameters; null if vibration is not desired.
  final NotificationVibrateParams? vibrate;

  const NotificationCommand({this.led, this.beep, this.vibrate});

  factory NotificationCommand.fromMap(Map<String, dynamic> map) {
    return NotificationCommand(
      led: map['led'] != null
          ? NotificationLEDParams.fromMap(Map<String, dynamic>.from(map['led']))
          : null,
      beep: map['beep'] != null
          ? NotificationBeepParams.fromMap(Map<String, dynamic>.from(map['beep']))
          : null,
      vibrate: map['vibrate'] != null
          ? NotificationVibrateParams.fromMap(Map<String, dynamic>.from(map['vibrate']))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'led': led?.toMap(),
      'beep': beep?.toMap(),
      'vibrate': vibrate?.toMap(),
    };
  }
}