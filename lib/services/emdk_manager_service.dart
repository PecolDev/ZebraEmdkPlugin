import 'package:zebra_emdk_plugin/generated/emdk_manager.dart';
import 'package:zebra_emdk_plugin/services/barcode_manager_service.dart';
import 'package:zebra_emdk_plugin/services/notification_manager_service.dart';
import 'package:zebra_emdk_plugin/services/platform_service_base.dart';
import 'package:zebra_emdk_plugin/services/profile_manager_service.dart';

class EmdkManagerService extends PlatformServiceBase {
  BarcodeManagerService? _barcodeManager;
  NotificationManagerService? _notificationManager;
  ProfileManagerService? _profileManager;

  EmdkManagerService() : super(methodPrefix: 'emdkManager') {
    initEventChannel('emdk_manager_event_channel');
  }

  /// This method is the key function to initialize the EMDK Manager.
  /// 
  /// The EMDK Manager must be called before any other Manager.
  Future<EMDKStatusCode?> initialize() async {
    var result = await invokeMethod<String>("initialize");

    if (result != null) return EMDKStatusCode.fromValue(result);
    
    return null;
  }

  /// Gets the BarcodeManagerService instance.
  /// EMDKManager must be successfully initialized first.
  BarcodeManagerService getBarcodeManager() {
    _barcodeManager ??= BarcodeManagerService();
    return _barcodeManager!;
  }

  /// Gets the NotificationManagerService instance.
  /// EMDKManager must be successfully initialized first.
  NotificationManagerService getNotificationManager() {
    _notificationManager ??= NotificationManagerService();
    return _notificationManager!;
  }

  /// Gets the ProfileManagerService instance.
  /// EMDKManager must be successfully initialized first.
  ProfileManagerService getProfileManager() {
    _profileManager ??= ProfileManagerService();
    return _profileManager!;
  }

  Stream<void> get onOpened => typedEvent('onOpened').map((_) {});

  Stream<void> get onClosed => typedEvent('onClosed').map((_) {});
}