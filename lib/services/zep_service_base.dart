import 'dart:developer';

import 'package:flutter/services.dart';

/// Base class for all `new_services/` service wrappers.
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
  Future<T?> invokeMethod<T>(String method, [dynamic arguments]) async {
    try {
      return await _methodChannel.invokeMethod<T>(method, arguments);
    } on PlatformException catch (e) {
      log('[ZEP/$_handlerName] !! $method | ${e.code}: ${e.message}');
    }
    return null;
  }

  /// Returns a broadcast stream of all events from this handler's EventChannel.
  Stream<dynamic> get _events {
    _broadcastStream ??=
        _eventChannel.receiveBroadcastStream().asBroadcastStream();
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
