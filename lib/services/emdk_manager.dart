import 'package:zebra_emdk_plugin/generated/emdk_manager.dart';
import 'package:zebra_emdk_plugin/services/barcode_manager.dart';
import 'package:zebra_emdk_plugin/services/notification_manager.dart';
import 'package:zebra_emdk_plugin/services/profile_manager.dart';
import 'package:zebra_emdk_plugin/services/zep_service_base.dart';

/// Dart binding for `EmdkManagerHandler` (Kotlin).
///
/// Channels:
///   - MethodChannel : `zep/methods/emdk_manager`
///   - EventChannel  : `zep/events/emdk_manager`
///
/// Usage:
/// ```dart
/// final emdk = EmdkManager();
/// emdk.onOpened.listen((_) { /* EMDK is ready */ });
/// await emdk.initialize();
/// ```
class EmdkManager extends ZepServiceBase {
  BarcodeManager? _barcodeManager;
  NotificationManager? _notificationManager;
  ProfileManager? _profileManager;

  EmdkManager() : super('emdk_manager');

  // ─── Methods ───────────────────────────────────────────────────────────────

  /// Requests the EMDK Manager from the OS.
  ///
  /// Returns the [EMDKStatusCode] describing the request result.
  /// The EMDK will be ready once [onOpened] fires.
  Future<EMDKStatusCode?> initialize() async {
    final result = await invokeMethod<String>('initialize');
    if (result != null) return EMDKStatusCode.fromValue(result);
    return null;
  }

  /// Releases all EMDK resources. Call when the app is closing.
  Future<bool?> dispose() async => invokeMethod<bool>('dispose');

  // ─── Sub-managers ──────────────────────────────────────────────────────────

  /// Returns the [BarcodeManager] instance.
  /// Only call after [onOpened] has fired.
  BarcodeManager get barcodeManager {
    _barcodeManager ??= BarcodeManager();
    return _barcodeManager!;
  }

  /// Returns the [NotificationManager] instance.
  /// Only call after [onOpened] has fired.
  NotificationManager get notificationManager {
    _notificationManager ??= NotificationManager();
    return _notificationManager!;
  }

  /// Returns the [ProfileManager] instance.
  /// Only call after [onOpened] has fired.
  ProfileManager get profileManager {
    _profileManager ??= ProfileManager();
    return _profileManager!;
  }

  // ─── Events ────────────────────────────────────────────────────────────────

  /// Fires when the EMDK is successfully opened and all sub-managers
  /// are available on the native side.
  Stream<void> get onOpened => typedEvent('onOpened').map((_) {});

  /// Fires when the EMDK connection is closed (e.g. on app pause/destroy).
  Stream<void> get onClosed => typedEvent('onClosed').map((_) {});
}