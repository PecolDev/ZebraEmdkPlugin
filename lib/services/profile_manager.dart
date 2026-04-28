import 'package:zebra_emdk_plugin/generated/emdk_manager.dart';
import 'package:zebra_emdk_plugin/services/zep_service_base.dart';

/// Dart binding for `ProfileManagerHandler` (Kotlin).
///
/// Channels:
///   - MethodChannel : `zep/methods/profile_manager`
///   - EventChannel  : `zep/events/profile_manager`
///
/// The Kotlin `ProfileManager.processProfileAsync` call is fire-and-forget
/// from the Dart side — results come back through [onData].
class ProfileManager extends ZepServiceBase {
  ProfileManager() : super('profile_manager');

  // ─── Methods ───────────────────────────────────────────────────────────────

  /// Sends an MX XML profile to the Zebra Profile Manager for processing.
  ///
  /// [characteristics] - XML string with characteristics only.
  ///
  /// This is fire-and-forget: the method returns immediately and the native
  /// result is delivered via [onData].
  void processProfileAsync(String characteristics) {
    invokeMethod('processProfile', characteristics);
  }

  /// Requests permission for a service using the provided [uri].
  ///
  /// This is fire-and-forget: the method returns immediately and the native
  /// result is delivered via [onData].
  void requestServicePermission(String uri) {
    invokeMethod('requestServicePermission', uri);
  }

  /// Queries a content provider [uri] and returns the first column of the
  /// first row as a String.
  ///
  /// Used to resolve Zebra OEMinfo URIs such as the Bluetooth MAC address.
  /// Returns `null` if the URI cannot be resolved or the cursor is empty.
  Future<String?> resolveCursorUri(String uri) async =>
      invokeMethod<String>('resolveCursorUri', uri);

  // ─── Events ────────────────────────────────────────────────────────────────

  /// Fires when the native ProfileManager finishes processing a profile.
  ///
  /// The [ProfileResultData] contains the status code, extended status,
  /// profile name, flag, and the full XML string that was processed.
  Stream<ProfileResultData?> get onData {
    return typedEvent<ProfileResultData>(
      'onData',
      factory: (payload) => ProfileResultData.fromMap(payload),
    );
  }
}