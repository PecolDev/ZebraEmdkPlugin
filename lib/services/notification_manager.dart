import 'package:zebra_emdk_plugin/generated/notification.dart';
import 'package:zebra_emdk_plugin/services/zep_service_base.dart';

/// Dart binding for `NotificationManagerHandler` (Kotlin).
///
/// In the new architecture the notification device operations (init, notify)
/// live directly on this handler — there is no separate NotificationDevice
/// handler.
///
/// Channels:
///   - MethodChannel : `zep/methods/notification_manager`
///   - EventChannel  : `zep/events/notification_manager`
class NotificationManager extends ZepServiceBase {
  NotificationManager() : super('notification_manager');

  // ─── Device discovery ──────────────────────────────────────────────────────

  /// Returns all notification devices known to the EMDK, connected or not.
  Future<List<NotificationDeviceInfo>?> getSupportedDevices() async {
    final result = await invokeMethod<Map>('getSupportedDevices');
    if (result == null || !result.containsKey('devicesList')) return null;
    final list = result['devicesList'] as List?;
    return list
        ?.map((e) =>
            NotificationDeviceInfo.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  /// Returns only the notification devices that are currently connected.
  Future<List<NotificationDeviceInfo>?> getConnectedDevices() async {
    final result = await invokeMethod<Map>('getConnectedDevices');
    if (result == null || !result.containsKey('devicesList')) return null;
    final list = result['devicesList'] as List?;
    return list
        ?.map((e) =>
            NotificationDeviceInfo.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  // ─── Device lifecycle ──────────────────────────────────────────────────────

  /// Enables the notification device identified by [friendlyName].
  ///
  /// The device must be connected. Returns `true` on success.
  Future<bool?> initDevice(String friendlyName) async =>
      invokeMethod<bool>('initDevice', friendlyName);

  /// Disables and releases the active notification device.
  Future<bool?> deinitDevice() async => invokeMethod<bool>('deinitDevice');

  // ─── Device state ──────────────────────────────────────────────────────────

  /// Returns info about the currently active (default) notification device.
  Future<NotificationDeviceInfo?> getDeviceInfo() async {
    final result = await invokeMethod('getDeviceInfo');
    if (result == null) return null;
    return NotificationDeviceInfo.fromMap(Map<String, dynamic>.from(result));
  }

  // ─── Notification ──────────────────────────────────────────────────────────

  /// Triggers a [NotificationCommand] (LED / Beep / Vibrate) on the active device.
  Future<bool?> notify(NotificationCommand command) async =>
      invokeMethod<bool>('notify', command.toMap());
}