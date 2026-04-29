import 'package:zebra_emdk_plugin/generated/key_identifiers.dart';
import 'package:zebra_emdk_plugin/services/zep_service_base.dart';

/// Dart binding for `KeyEventHandler` (Kotlin).
///
/// Channels:
///   - EventChannel : `zep/events/key_event`
///
/// The native side registers a `BroadcastReceiver` for the intent
/// automatically when the app starts. No setup is required
/// from Flutter.
///
/// Usage:
/// ```dart
/// Emdk().keyEventManager.onKeyDown.listen((key) {
///   print('Key pressed: ${key?.name}');   // e.g. KeyIdentifier.p1
/// });
/// ```
class KeyEventManager extends ZepServiceBase {
  KeyEventManager() : super('key_event');

  // ─── Events ────────────────────────────────────────────────────────────────

  /// Fires whenever the device sends a `KEY_DOWN_EVENT` broadcast.
  ///
  /// The emitted [KeyIdentifier] corresponds to the key defined in the
  /// Zebra MX KeyMappingMgr profile (e.g. [KeyIdentifier.p1],
  /// [KeyIdentifier.enter], [KeyIdentifier.a]).
  ///
  /// Returns `null` if the value sent by the native side does not match any
  /// known [KeyIdentifier] (e.g. an unrecognised custom key string).
  Stream<KeyIdentifier?> get onKeyDown {
    return typedEvent<KeyIdentifier?>(
      'onKeyDown',
      factory: (payload) {
        final raw = payload['key'] as String?;
        if (raw == null) return null;
        try {
          return KeyIdentifier.fromValue(raw);
        } catch (_) {
          return null;
        }
      },
    );
  }
}
