import 'package:zebra_emdk_plugin_example/content_uris.dart';
import 'package:zebra_emdk_plugin/custom_models/connection_change.dart';
import 'package:zebra_emdk_plugin/generated/emdk_manager.dart';
import 'package:zebra_emdk_plugin/generated/notification.dart';
import 'package:zebra_emdk_plugin/generated/scan_data.dart';
import 'package:zebra_emdk_plugin/generated/scanner.dart';
import 'package:zebra_emdk_plugin/generated/scanner_config.dart';
import 'package:zebra_emdk_plugin_example/mx_profiles.dart';
import 'package:zebra_emdk_plugin/services/emdk_manager.dart';

class Emdk {
  late EmdkManager _emdkManager;
  bool _readEnabled = true;

  static const _scannerPriorities = [
    'Zebra Bluetooth Scanner', // RS2100 is recognized with this name
    '2D Barcode Imager',
    'Camera Scanner'
  ];

  static const _devicePriorities = [
    'Zebra Bluetooth Scanner'
  ];

  Emdk._();

  factory Emdk() => _instance;

  static final Emdk _instance = Emdk._();

  Stream<ScanDataCollection?> get onDataRead => _emdkManager.barcodeManager.onData;
  Stream<ProfileResultData?> get onProfileData => _emdkManager.profileManager.onData;

  Future<void> initialize() async {
    _emdkManager = EmdkManager();

    _emdkManager.onOpened.listen((_) => _onEmdkOpened());

    await _emdkManager.initialize();
  }

  Future<void> dispose() async {
    await _emdkManager.dispose();
  }

  Future<void> enableRead() async {
    await _emdkManager.barcodeManager.enableRead();
    _readEnabled = true;
  }

  Future<void> disableRead() async {
    await _emdkManager.barcodeManager.disableRead();
    _readEnabled = false;
  }

  Future<void> notifyDevice(NotificationCommand command) async {
    await disableRead();
    await _emdkManager.notificationManager.notify(command);
    await enableRead();
  }

  Future<void> setScannerConfig(ScannerConfig config) async {
    await disableRead();
    await _emdkManager.barcodeManager.setConfig(config);
    await enableRead();
  }

  Future<String?> getPeripheralBatteryInfo() async {
    var batteryInfo = await _emdkManager.profileManager.resolveCursorUri(ContentUris.peripheralBatteryInfo);

    return batteryInfo;
  }

  Future<String?> getBluetoothMacAddress() async {
    var btMac = await _emdkManager.profileManager.resolveCursorUri(ContentUris.bluetoothMac);

    return btMac;
  }

  Future<String?> getPairingCode() async {
    var btMac = await getBluetoothMacAddress();

    if(btMac == null || btMac.isEmpty) return null;

    return '{3}B${btMac.replaceAll(":", "").toUpperCase()}';
  }

  void _onEmdkOpened() async {
    _emdkManager.barcodeManager.onConnectionChange.listen(_onConnectionChange);
    _emdkManager.barcodeManager.onStatus.listen(_onScannerStatus);

    applyAccessMgrPermissionsProfile();

    clearPairedDevices();
    enablePairing();

    await _setDefaultScanner();
    await _setDefaultNotificationDevice();
  }

  void _onScannerStatus(StatusData? statusData) async {
    if (statusData != null) {
        switch (statusData.state) {
          case ScannerStates.idle:
            if(_readEnabled) await _emdkManager.barcodeManager.enableRead();

            break;
          case ScannerStates.waiting:
          case ScannerStates.scanning:
          case ScannerStates.disabled:
          case ScannerStates.error:
          default:
            break;
        }
      }
  }

  void _onConnectionChange(ConnectionChange? connectionChange) async {
    if(connectionChange == null) return;

    if (connectionChange.connectionState == BarcodeManagerConnectionState.connected){
      disablePairing();
    }
    else if(connectionChange.connectionState == BarcodeManagerConnectionState.disconnected){
      clearPairedDevices();
      enablePairing();
    }

    await _setDefaultScanner();
    await _setDefaultNotificationDevice();
  }

  Future<bool> _setDefaultScanner() async {
    var scanners = await _emdkManager.barcodeManager.getConnectedScanners();

    if(scanners != null && scanners.isNotEmpty){
      for(final friendlyName in _scannerPriorities){
        final scanner = scanners.where((e) => e.friendlyName == friendlyName).firstOrNull;

        if(scanner != null){
          var result = await _emdkManager.barcodeManager.initScanner(scanner.friendlyName!);

          if(result == true) return true;
        }
      }

      final scanner = scanners.where((e) => e.isDefaultScanner ?? false).firstOrNull;

      if(scanner != null){
        var result = await _emdkManager.barcodeManager.initScanner(scanner.friendlyName!);

        if(result == true) return true;
      }
    }

    await _emdkManager.barcodeManager.deinitScanner();

    return false;
  }

  Future<bool> _setDefaultNotificationDevice() async {
    var scanners = await _emdkManager.notificationManager.getConnectedDevices();

    if(scanners != null && scanners.isNotEmpty){
      for(final friendlyName in _devicePriorities){
        final device = scanners.where((e) => e.friendlyName == friendlyName).firstOrNull;

        if(device != null){
          var result = await _emdkManager.notificationManager.initDevice(device.friendlyName!);

          if(result == true) return true;
        }
      }

      final device = scanners.where((e) => e.isDefaultDevice ?? false).firstOrNull;

      if(device != null){
        var result = await _emdkManager.notificationManager.initDevice(device.friendlyName!);

        if(result == true) return true;
      }
    }

    await _emdkManager.notificationManager.deinitDevice();

    return false;
  }

  void addRestrictions() {
    _emdkManager.profileManager.processProfileAsync(MxProfiles.addRestrictions);
  }

  void removeRestrictions() {
    _emdkManager.profileManager.processProfileAsync(MxProfiles.removeRestrictions);
  }

  void clearPairedDevices() {
    _emdkManager.profileManager.processProfileAsync(MxProfiles.clearPairedDevices);
  }

  void enableBluetooth() {
    _emdkManager.profileManager.processProfileAsync(MxProfiles.enableBluetooth);
  }

  void disableBluetooth() {
    _emdkManager.profileManager.processProfileAsync(MxProfiles.disableBluetooth);
  }

  void enableNfc() {
    _emdkManager.profileManager.processProfileAsync(MxProfiles.enableNfc);
  }

  void disableNfc() {
    _emdkManager.profileManager.processProfileAsync(MxProfiles.disableNfc);
  }

  void enablePairing() {
    _emdkManager.profileManager.processProfileAsync(MxProfiles.enablePairing);
  }

  void disablePairing() {
    _emdkManager.profileManager.processProfileAsync(MxProfiles.disablePairing);
  }

  void rebootDevice() {
    _emdkManager.profileManager.processProfileAsync(MxProfiles.reboot);
  }

  void fullDeviceWipe() {
    _emdkManager.profileManager.processProfileAsync(MxProfiles.fullDeviceWipe);
  }

  void resetScanner(){
    _emdkManager.profileManager.processProfileAsync(MxProfiles.resetScanner);
  }

  void unpairCurrentScanner(){
    _emdkManager.profileManager.processProfileAsync(MxProfiles.unpairCurrentScanner);
  }

  void disconnectCurrentScanner(){
    _emdkManager.profileManager.processProfileAsync(MxProfiles.disconnectCurrentScanner);
  }

  void locateCurrentScanner(){
    _emdkManager.profileManager.processProfileAsync(MxProfiles.locateCurrentScanner);
  }

  void applyAccessMgrPermissionsProfile() {
    _emdkManager.profileManager.requestServicePermission(ContentUris.bluetoothMac);
    _emdkManager.profileManager.requestServicePermission(ContentUris.buildSerial);
    _emdkManager.profileManager.requestServicePermission(ContentUris.productModel);
    _emdkManager.profileManager.requestServicePermission(ContentUris.wifiMac);
    _emdkManager.profileManager.requestServicePermission(ContentUris.peripheralBatteryInfo);
  }
}