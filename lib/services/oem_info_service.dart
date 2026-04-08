import 'package:zebra_emdk_plugin/services/platform_service_base.dart';

class OemInfoService extends PlatformServiceBase {
  // Package-private constructor accessed by ProfileManagerService
  OemInfoService.internal() : super(methodPrefix: 'oemInfo');

  /// Retrieves the Bluetooth MAC address by querying the Zebra OEMinfo content provider.
  /// On Android 10+, this natively configures an AccessMgr profile to whitelist the application
  /// signature in the background before querying, circumventing Google's restrictions.
  Future<String?> getBluetoothMac() async {
    return await invokeMethod<String>("getBluetoothMac");
  }

  /// Retrieves the hardware Serial Number natively from the Zebra OEMinfo content provider.
  Future<String?> getSerialNumber() async {
    return await invokeMethod<String>("getSerialNumber");
  }

  Future<String?> getProductModel() async {
    return await invokeMethod<String>("getProductModel");
  }

  Future<String?> getWifiMac() async {
    return await invokeMethod<String>("getWifiMac");
  }

  /// Only works with Device Central app installed on device
  Future<String?> getPeripheralBatteryInfo() async {
    return await invokeMethod<String>("getPeripheralBatteryInfo");
  }

  /// Only works with Device Central app installed on device
  Future<String?> getPeripheralDeviceInfo() async {
    return await invokeMethod<String>("getPeripheralDeviceInfo");
  }
}
