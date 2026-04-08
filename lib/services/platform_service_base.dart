import 'dart:developer';

import 'package:flutter/services.dart';

abstract class PlatformServiceBase {
  static const MethodChannel _sharedMethodChannel = MethodChannel('zebra_emdk_plugin/methods');
  late final EventChannel eventChannel;
  
  final String methodPrefix;

  Stream<dynamic>? _sharedStream;

  PlatformServiceBase({required this.methodPrefix});

  /// Call this in your service constructor to initialize its specific EventChannel
  void initEventChannel(String eventChannelName) {
    eventChannel = EventChannel(eventChannelName);
  }

  /// Method calls are prefixed automatically based on the service (e.g., 'barcodeManager#initialize')
  Future<T?> invokeMethod<T>(String name, [dynamic arguments]) async {
    final callName = '$methodPrefix#$name';
    
    try {
      return await _sharedMethodChannel.invokeMethod<T>(callName, arguments);
    } on PlatformException catch (e) {
      log('[EMDK_METHOD] !! $callName | Error: ${e.message}');
    }

    return null;
  }

  Stream<T?> typedEvent<T>(
    String type, {
    T Function(Map<String, dynamic> map)? factory,
  }) {
    return _events
        .where((e) => e['type'] == type)
        .map((e) {
          final payload = Map<String, dynamic>.from(e['payload'] ?? {});

          if (factory != null) {
            return factory(payload);
          }

          // No payload → emit void signal
          return null;
        });
  }

  Stream<dynamic> get _events {
    _sharedStream ??=
        eventChannel.receiveBroadcastStream().asBroadcastStream();
    return _sharedStream!;
  }
}