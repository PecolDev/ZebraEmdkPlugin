import 'package:zebra_emdk_plugin/generated/scan_data.dart';
import 'package:zebra_emdk_plugin/generated/scanner_config.dart';
import 'package:zebra_emdk_plugin/generated/scanner.dart';
import 'package:zebra_emdk_plugin/services/platform_service_base.dart';

class ScannerService extends PlatformServiceBase {
  // Internal constructor accessed by BarcodeManagerService
  ScannerService.internal() : super(methodPrefix: 'scanner') {
    initEventChannel('scanner_event_channel');
  }

  /// Initializes the Scanner and implements the data listener and status listener.
  Future<bool?> initialize() async => await invokeMethod<bool>("initialize");

  /// Disposes the Scanner and removes the listeners.
  Future<bool?> dispose() async => await invokeMethod<bool>("dispose");

  Future<ScannerInfo?> getScannerInfo() async {
    var result = await invokeMethod("getScannerInfo");

    if(result != null) return ScannerInfo.fromMap(Map<String, dynamic>.from(result));
    
    return null;
  }

  Future<ScannerConfig?> getConfig() async {
    var result = await invokeMethod("getConfig");
    if(result != null) return ScannerConfig.fromMap(Map<String, dynamic>.from(result));
    return null;
  }

  Future<bool?> setConfig(ScannerConfig config) async {
    return await invokeMethod<bool>("setConfig", config.toMap());
  }

  Future<bool?> enableRead() async => await invokeMethod<bool>("enableRead");

  Future<bool?> disableRead() async => await invokeMethod<bool>("disableRead");

  Stream<StatusData?> get onStatus {
    return typedEvent<StatusData>('onStatus', factory: (map) => StatusData.fromMap(map));
  }

  Stream<ScanDataCollection?> get onData {
    return typedEvent<ScanDataCollection>('onData', factory: (map) => ScanDataCollection.fromMap(map));
  }
}