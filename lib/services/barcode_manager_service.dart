import 'package:zebra_emdk_plugin/generated/scanner.dart';
import 'package:zebra_emdk_plugin/custom_models/connection_change.dart';
import 'package:zebra_emdk_plugin/services/platform_service_base.dart';
import 'package:zebra_emdk_plugin/services/scanner_service.dart';

class BarcodeManagerService extends PlatformServiceBase {
  ScannerService? _scannerService;

  // Package-private constructor accessed by EmdkManagerService
  BarcodeManagerService() : super(methodPrefix: 'barcodeManager') {
    initEventChannel('barcode_manager_event_channel');
  }

  /// Gets the Scanner instance for a specific ScannerInfo.
  ScannerService getScannerService() {
    // In a fully featured SDK this would instanciate a distinct object per scanner.
    // For this implementation, we return our singleton wrapper that communicates
    // with the native side's actively selected scanner.
    _scannerService ??= ScannerService.internal();
    return _scannerService!;
  }

  /// Initializes the Barcode Manager and implements the connection listener.
  Future<bool?> initialize() async => await invokeMethod<bool>("initialize");

  /// Disposes the Barcode Manager and removes the connection listener.
  Future<bool?> dispose() async => await invokeMethod<bool>("dispose");

  Future<List<ScannerInfo>?> getSupportedScanners() async {
    var result = await invokeMethod<Map>("getSupportedScanners");

    if (result == null || !result.containsKey('devicesList')) return null;

    var list = result['devicesList'] as List?;
    return list?.map((e) => ScannerInfo.fromMap(Map<String, dynamic>.from(e))).toList();
  }

  Future<bool?> setScannerTypeByFriendlyName(String friendlyName) async {
    return await invokeMethod<bool>("setScannerTypeByFriendlyName", friendlyName);
  }

  Stream<ConnectionChange?> get onConnectionChange {
    return typedEvent<ConnectionChange>('onConnectionChange', factory: (map) => ConnectionChange.fromMap(map));
  }
}