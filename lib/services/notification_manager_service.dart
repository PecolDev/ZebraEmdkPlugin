import 'package:zebra_emdk_plugin/generated/notification.dart';
import 'package:zebra_emdk_plugin/services/notification_device_service.dart';
import 'package:zebra_emdk_plugin/services/platform_service_base.dart';

class NotificationManagerService extends PlatformServiceBase {
  NotificationDeviceService? _notificationDeviceService;

  NotificationManagerService() : super(methodPrefix: 'notificationManager');

  NotificationDeviceService getNotificationDeviceService() {
    _notificationDeviceService ??= NotificationDeviceService.internal();

    return _notificationDeviceService!;
  }

  /// Initializes the Barcode Manager and implements the connection listener.
  Future<bool?> initialize() async => await invokeMethod<bool>("initialize");

  /// Gets a list of all supported notification devices on this hardware.
  Future<List<NotificationDeviceInfo>?> getSupportedDevices() async {
    var result = await invokeMethod<List>("getSupportedDevices");

    if (result == null) return null;

    return result.map((e) => NotificationDeviceInfo.fromMap(Map<String, dynamic>.from(e))).toList();
  }

  Future<bool?> setNotificationDeviceByFriendlyName(String friendlyName) async {
    return await invokeMethod<bool>("setNotificationDeviceByFriendlyName", friendlyName);
  }
}