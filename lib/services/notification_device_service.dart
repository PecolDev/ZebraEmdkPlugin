import 'package:zebra_emdk_plugin/generated/notification.dart';
import 'package:zebra_emdk_plugin/services/platform_service_base.dart';

class NotificationDeviceService extends PlatformServiceBase {
  // Internal constructor accessed by NotificationManagerService
  NotificationDeviceService.internal() : super(methodPrefix: 'notificationDevice');

  /// Enables the notification device.
  Future<bool?> initialize() async => await invokeMethod<bool>("initialize");

  /// Disables the notification device.
  Future<bool?> dispose() async => await invokeMethod<bool>("dispose");

  /// Triggers a notification sequence (LED, Beep, Vibrate) on the device.
  Future<bool?> notify(NotificationCommand command) async => await invokeMethod<bool>("notify", command.toMap());

  Future<NotificationDeviceInfo?> getNotificationDeviceInfo() async {
    var result = await invokeMethod("getNotificationDeviceInfo");

    if(result != null) return NotificationDeviceInfo.fromMap(Map<String, dynamic>.from(result));
    
    return null;
  }
}
