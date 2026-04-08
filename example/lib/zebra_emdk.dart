import 'package:zebra_emdk_plugin/custom_models/connection_change.dart';
import 'package:zebra_emdk_plugin/generated/emdk_manager.dart';
import 'package:zebra_emdk_plugin/generated/notification.dart';
import 'package:zebra_emdk_plugin/generated/scan_data.dart';
import 'package:zebra_emdk_plugin/generated/scanner.dart';
import 'package:zebra_emdk_plugin/generated/scanner_config.dart';
import 'package:zebra_emdk_plugin/services/emdk_manager_service.dart';

class ZebraEMDK {
  late final EmdkManagerService _emdkManager;
  bool _readEnabled = true;

  static const _scannerPriorities = [
    'Zebra Bluetooth Scanner', // RS2100 is recognized with this name
    '2D Barcode Imager',
    'Camera Scanner'
  ];

  ZebraEMDK._();

  factory ZebraEMDK() => _instance;

  static final ZebraEMDK _instance = ZebraEMDK._();

  void initialize(){
    _emdkManager = EmdkManagerService();
    
    _emdkManager.onOpened.listen((_) => _onEmdkOpened());
    
    _emdkManager.initialize();
  }

  Stream<ScanDataCollection?> get onDataRead => _emdkManager.getBarcodeManager().getScannerService().onData;

  Future<String?> getPeripheralDeviceInfo() async {
    var oemInfoService = _emdkManager.getProfileManager().getOemInfoService();

    return await oemInfoService.getPeripheralDeviceInfo();
  }

  void setProfile(String profileName, String xmlData) {
    var profileManager = _emdkManager.getProfileManager();

    profileManager.processProfileAsync(profileName, xmlData);
  }

  Future<String?> getPeripheralBatteryInfo() async {
    var oemInfoService = _emdkManager.getProfileManager().getOemInfoService();

    return await oemInfoService.getPeripheralBatteryInfo();
  }

  Future<void> enableRead() async {
    var barcodeManager = _emdkManager.getBarcodeManager();
    var scanner = barcodeManager.getScannerService();
    await scanner.enableRead();
    _readEnabled = true;
  }

  Future<void> disableRead() async {
    var barcodeManager = _emdkManager.getBarcodeManager();
    var scanner = barcodeManager.getScannerService();
    await scanner.disableRead();
    _readEnabled = false;
  }

  Future<void> notifyDevice(NotificationCommand command) async {
    var notificationManager = _emdkManager.getNotificationManager();
    var notificationDevice = notificationManager.getNotificationDeviceService();

    await disableRead();
    await notificationDevice.notify(command);
    await enableRead();
  }

  Future<void> setScannerConfig(ScannerConfig config) async {
    var barcodeManager = _emdkManager.getBarcodeManager();
    var scanner = barcodeManager.getScannerService();

    await disableRead();
    await scanner.setConfig(config);
    await enableRead();
  }

  Future<String?> getPairingCode() async {
    var oemInfoService = _emdkManager.getProfileManager().getOemInfoService();

    var btMacAdress = await oemInfoService.getBluetoothMac();

    return '{3}B${btMacAdress?.replaceAll(":", "").toUpperCase()}';
  }

  Future<String?> getBluetoothMacAddress() async {
    var oemInfoService = _emdkManager.getProfileManager().getOemInfoService();

    var btMacAdress = await oemInfoService.getBluetoothMac();

    return btMacAdress;
  }

  void _onEmdkOpened() async {
    await _initializeBarcodeManager();
    await _initializeProfileManager();
    await _initializeNotificationManager();
  }

  Future<bool> _initializeBarcodeManager() async {
    var barcodeManager = _emdkManager.getBarcodeManager();

    if(await barcodeManager.initialize() ?? false){
      barcodeManager.onConnectionChange.listen(_onConnectionChange);

      await _setDefaultScanner();

      return true;
    }

    return false;
  }

  Future<bool> _initializeProfileManager() async {
    var profileManager = _emdkManager.getProfileManager();

    if(await profileManager.initialize() ?? false){
      profileManager.onData.listen(_onProfileData);

      return true;
    }

    return false;
  }

  Future<bool> _initializeNotificationManager() async {
    var notificationManager = _emdkManager.getNotificationManager();

    if((await notificationManager.initialize()) ?? false){

      await _setDefaultNotificationDevice();

      return true;
    }

    return false;
  }

  Future<bool> _initializeScanner() async {
    var barcodeManager = _emdkManager.getBarcodeManager();

    var scanner = barcodeManager.getScannerService();

    scanner.onStatus.listen((status) async {
      if (status != null) {
        switch (status.state) {
          case ScannerStates.idle:
            if(_readEnabled) await scanner.enableRead();

            break;
          case ScannerStates.waiting:
          case ScannerStates.scanning:
          case ScannerStates.disabled:
          case ScannerStates.error:
          default:
            break;
        }
      }
    });

    var scannerInfo = await scanner.getScannerInfo();

    if(scannerInfo != null && (scannerInfo.isConnected ?? false)){
      await scanner.initialize();

      return true;
    }

    await scanner.dispose();

    return false;
  }

  Future<bool> _disposeScanner() async {
    var barcodeManager = _emdkManager.getBarcodeManager();

    var scanner = barcodeManager.getScannerService();
    
    await scanner.dispose();

    return true;
  }

  Future<bool> _initializeNotificationDevice() async {
    var notificationManager = _emdkManager.getNotificationManager();

    var notificationDevice = notificationManager.getNotificationDeviceService();

    var notificationDeviceInfo = await notificationDevice.getNotificationDeviceInfo();

    if(notificationDeviceInfo != null && (notificationDeviceInfo.isConnected ?? false)){
      await notificationDevice.initialize();

      return true;
    }

    await notificationDevice.dispose();

    return false;
  }

  Future<bool> _disposeNotificationDevice() async {
    var notificationManager = _emdkManager.getNotificationManager();

    var notificationDevice = notificationManager.getNotificationDeviceService();
    
    await notificationDevice.dispose();

    return true;
  }

  void _onProfileData(ProfileResultData? event){
    
  }

  void _onConnectionChange(ConnectionChange? connectionChange) async {
    if(connectionChange == null) return;

    await _disposeScanner();
    await _disposeNotificationDevice();

    await _setDefaultScanner();

    // When Device Central app is used, initializing the notification device breaks. So it is used a delay so it initializes without error.
    // The workaround I found was to delay the initialization.
    await Future.delayed(const Duration(milliseconds: 500));
    await _setDefaultNotificationDevice();
  }

  Future<void> _setDefaultScanner() async {
    var barcodeManager = _emdkManager.getBarcodeManager();

    var supportedScanners = await barcodeManager.getSupportedScanners();

    if(supportedScanners != null && supportedScanners.isNotEmpty){
      var connectedScanners = supportedScanners.where((scanner) => scanner.isConnected == true);

      if(connectedScanners.isNotEmpty){
        for (final friendlyName in _scannerPriorities) {
          final scanner = connectedScanners.where((e) => e.friendlyName == friendlyName).firstOrNull;

          if (scanner != null){
            await barcodeManager.setScannerTypeByFriendlyName(scanner.friendlyName!);

            await _initializeScanner();

            return;
          }
        }

        final scanner = connectedScanners.where((e) => e.isDefaultScanner ?? false).firstOrNull;

        if(scanner != null){
          await barcodeManager.setScannerTypeByFriendlyName(scanner.friendlyName!);

          await _initializeScanner();
        }
      }
    }
  }

  Future<void> _setDefaultNotificationDevice() async {
    var notificationManager = _emdkManager.getNotificationManager();
    
    var supportedNotificationDevices = await notificationManager.getSupportedDevices();

    if(supportedNotificationDevices != null && supportedNotificationDevices.isNotEmpty){
      var connectedNotificationDevices = supportedNotificationDevices.where((notificationDevice) => notificationDevice.isConnected == true);

      if(connectedNotificationDevices.isNotEmpty){
        for (final friendlyName in _scannerPriorities) {
          final notificationDevice = connectedNotificationDevices.where((e) => e.friendlyName == friendlyName).firstOrNull;

          if (notificationDevice != null){
            await notificationManager.setNotificationDeviceByFriendlyName(notificationDevice.friendlyName!);

            await _initializeNotificationDevice();

            return;
          }
        }

        final notificationDevice = connectedNotificationDevices.where((e) => e.isDefaultDevice ?? false).firstOrNull;

        if(notificationDevice != null){
          await notificationManager.setNotificationDeviceByFriendlyName(notificationDevice.friendlyName!);

          await _initializeNotificationDevice();
        }
      }
    }
  }
}