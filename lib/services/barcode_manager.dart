import 'package:zebra_emdk_plugin/custom_models/connection_change.dart';
import 'package:zebra_emdk_plugin/generated/scan_data.dart';
import 'package:zebra_emdk_plugin/generated/scanner.dart';
import 'package:zebra_emdk_plugin/generated/scanner_config.dart';
import 'package:zebra_emdk_plugin/services/zep_service_base.dart';

/// Dart binding for `BarcodeManagerHandler` (Kotlin).
///
/// In the new architecture the scanner operations (init, read, config) live
/// directly on this handler — there is no separate Scanner handler.
///
/// Channels:
///   - MethodChannel : `zep/methods/barcode_manager`
///   - EventChannel  : `zep/events/barcode_manager`
class BarcodeManager extends ZepServiceBase {
  BarcodeManager() : super('barcode_manager');

  // ─── Device discovery ──────────────────────────────────────────────────────

  /// Returns all scanners known to the EMDK, connected or not.
  Future<List<ScannerInfo>?> getSupportedScanners() async {
    final result = await invokeMethod<Map>('getSupportedScanners');
    if (result == null || !result.containsKey('devicesList')) return null;
    final list = result['devicesList'] as List?;
    return list
        ?.map((e) => ScannerInfo.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  /// Returns only the scanners that are currently connected.
  Future<List<ScannerInfo>?> getConnectedScanners() async {
    final result = await invokeMethod<Map>('getConnectedScanners');
    if (result == null || !result.containsKey('devicesList')) return null;
    final list = result['devicesList'] as List?;
    return list
        ?.map((e) => ScannerInfo.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  // ─── Scanner lifecycle ─────────────────────────────────────────────────────

  /// Initialises the scanner identified by [friendlyName].
  ///
  /// The scanner must be connected. Returns `true` on success.
  Future<bool?> initScanner(String friendlyName) async =>
      invokeMethod<bool>('initScanner', friendlyName);

  /// Disables, removes listeners from, and releases the active scanner.
  Future<bool?> deinitScanner() async => invokeMethod<bool>('deinitScanner');

  // ─── Scanner state ─────────────────────────────────────────────────────────

  /// Returns info about the currently active (default) scanner.
  Future<ScannerInfo?> getScannerInfo() async {
    final result = await invokeMethod('getScannerInfo');
    if (result == null) return null;
    return ScannerInfo.fromMap(Map<String, dynamic>.from(result));
  }

  // ─── Read control ──────────────────────────────────────────────────────────

  /// Arms the scanner to read a barcode.
  Future<bool?> enableRead() async => invokeMethod<bool>('enableRead');

  /// Cancels a pending read.
  Future<bool?> disableRead() async => invokeMethod<bool>('disableRead');

  // ─── Config ────────────────────────────────────────────────────────────────

  /// Retrieves the current scanner configuration.
  Future<ScannerConfig?> getConfig() async {
    final result = await invokeMethod('getConfig');
    if (result == null) return null;
    return ScannerConfig.fromMap(Map<String, dynamic>.from(result));
  }

  /// Applies [config] to the active scanner.
  Future<bool?> setConfig(ScannerConfig config) async =>
      invokeMethod<bool>('setConfig', config.toMap());

  // ─── Events ────────────────────────────────────────────────────────────────

  /// Fires whenever a scanner connects or disconnects.
  Stream<ConnectionChange?> get onConnectionChange {
    return typedEvent<ConnectionChange>(
      'onConnectionChange',
      factory: (payload) => ConnectionChange.fromMap(payload),
    );
  }

  /// Fires when the scanner status changes (idle, scanning, disabled, …).
  Stream<StatusData?> get onStatus {
    return typedEvent<StatusData>(
      'onStatus',
      factory: (payload) => StatusData.fromMap(payload),
    );
  }

  /// Fires when scan data is available.
  Stream<ScanDataCollection?> get onData {
    return typedEvent<ScanDataCollection>(
      'onData',
      factory: (payload) => ScanDataCollection.fromMap(payload),
    );
  }
}