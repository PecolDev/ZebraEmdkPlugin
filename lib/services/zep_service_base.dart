import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:zebra_emdk_plugin/generated/emdk_manager.dart';
import 'package:zebra_emdk_plugin/generated/notification.dart';
import 'package:zebra_emdk_plugin/generated/scan_data.dart';

/// Base class for all `services/` service wrappers.
///
/// Each handler on the Kotlin side owns its own channels:
///   - MethodChannel : `zep/methods/<handlerName>`
///   - EventChannel  : `zep/events/<handlerName>`
///
/// Method calls are made directly (no prefix), matching the `when (methodCall.method)`
/// blocks in each Kotlin handler.
///
/// Events arrive as a `Map` with the envelope:
/// ```json
/// { "type": "onOpened", "payload": {...}, "timestamp": 1234567890 }
/// ```
///
/// ## Error propagation
///
/// When the native side throws a Zebra EMDK exception, it encodes it into a
/// [PlatformException] with a structured `code` and `details` map. This base
/// class decodes those back into the correct typed Dart exception and rethrows:
///
/// | Kotlin exception        | PlatformException code    | Dart exception          |
/// |-------------------------|---------------------------|-------------------------|
/// | `ScannerException`      | `SCANNER_EXCEPTION`       | [ScannerException]      |
/// | `NotificationException` | `NOTIFICATION_EXCEPTION`  | [NotificationException] |
/// | `EMDKException`         | `EMDK_EXCEPTION`          | [EMDKException]         |
/// | any other `Exception`   | `NATIVE_EXCEPTION`        | [PlatformException]     |
abstract class ZepServiceBase {
  final String _handlerName;

  late final MethodChannel _methodChannel;
  late final EventChannel _eventChannel;

  Stream<dynamic>? _broadcastStream;

  ZepServiceBase(String handlerName) : _handlerName = handlerName {
    _methodChannel = MethodChannel('zep/methods/$_handlerName');
    _eventChannel = EventChannel('zep/events/$_handlerName');
  }

  /// Invokes [method] on this handler's MethodChannel with optional [arguments].
  ///
  /// Throws a typed Zebra exception ([ScannerException], [NotificationException],
  /// or [EMDKException]) when the native side reports a known EMDK error.
  /// Re-throws [PlatformException] as-is for unknown native errors so callers
  /// always receive a meaningful exception instead of a silent `null`.
  Future<T?> invokeMethod<T>(String method, [dynamic arguments]) async {
    try {
      return await _methodChannel.invokeMethod<T>(method, arguments);
    } on PlatformException catch (e) {
      log('[ZEP/$_handlerName] !! $method | ${e.code}: ${e.message}');
      _throwTypedException(e);
    }
  }

  /// Decodes a [PlatformException] into the matching typed Zebra exception
  /// and throws it. Falls back to rethrowing the original [PlatformException]
  /// for codes not mapped to a known EMDK type.
  Never _throwTypedException(PlatformException e) {
    final details = e.details is Map
        ? Map<String, dynamic>.from(e.details as Map)
        : <String, dynamic>{};

    switch (e.code) {
      case 'SCANNER_EXCEPTION':
        throw ScannerException.fromMap({
          'result': details['result'],
          'message': e.message,
        });
      case 'NOTIFICATION_EXCEPTION':
        throw NotificationException.fromMap({
          'result': details['result'],
          'message': e.message,
        });
      case 'EMDK_EXCEPTION':
        throw EMDKException.fromMap({
          'result': details['result'] != null
              ? Map<String, dynamic>.from(details['result'] as Map)
              : null,
          'message': e.message,
        });
      default:
        // Unknown native exception — rethrow the original so it is never lost.
        throw e;
    }
  }

  /// Returns a broadcast stream of all events from this handler's EventChannel.
  Stream<dynamic> get _events {
    _broadcastStream ??= _eventChannel
        .receiveBroadcastStream()
        .handleError((Object e) {
          log('[ZEP/$_handlerName] EventChannel error: $e');
        })
        .asBroadcastStream();
    return _broadcastStream!;
  }

  /// Filters the event stream for events matching [type] and optionally
  /// transforms the payload map into a typed object via [factory].
  Stream<T?> typedEvent<T>(
    String type, {
    T Function(Map<String, dynamic> payload)? factory,
  }) {
    return _events
        .where((e) => e is Map && e['type'] == type)
        .map((e) {
          final rawPayload = (e as Map)['payload'];
          final payload = rawPayload is Map
              ? Map<String, dynamic>.from(rawPayload)
              : <String, dynamic>{};

          if (factory != null) return factory(payload);
          return null;
        });
  }
}
