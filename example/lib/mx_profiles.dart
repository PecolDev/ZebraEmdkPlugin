class MxProfiles {
  static const String addRestrictions =
      '<characteristic type="UiMgr">'
        '<parm name="BluetoothPairingPopupUsage" value="2"/>'
        '<parm name="NotificationPullDown" value="2"/>'
        '<parm name="NavigationBarUsage" value="2"/>'
        '<parm name="StatusBarUsage" value="2"/>'
        '<parm name="RecentAppButtonUsage" value="2"/>'
        '<parm name="LargeScreenTaskbarUsage" value="2"/>'
      '</characteristic>'
      '<characteristic type="DevAdmin">'
        '<parm name="ScreenLockType" value="5"/>'
      '</characteristic>'
      '<characteristic type="DisplayMgr">'
        '<parm name="TimeoutInterval" value="65535"/>'
        '<parm name="Brightnesslevel" value="100"/>'
        '<parm name="Autorotate" value="2"/>'
      '</characteristic>';

  static const String removeRestrictions =
      '<characteristic type="UiMgr">'
        '<parm name="BluetoothPairingPopupUsage" value="1"/>'
        '<parm name="NotificationPullDown" value="1"/>'
        '<parm name="NavigationBarUsage" value="1"/>'
        '<parm name="StatusBarUsage" value="1"/>'
        '<parm name="RecentAppButtonUsage" value="1"/>'
        '<parm name="LargeScreenTaskbarUsage" value="1"/>'
      '</characteristic>'
      '<characteristic type="DevAdmin">'
        '<parm name="ScreenLockType" value="1"/>'
      '</characteristic>'
      '<characteristic type="DisplayMgr">'
        '<parm name="TimeoutInterval" value="600"/>'
        '<parm name="Brightnesslevel" value="80"/>'
        '<parm name="Autorotate" value="1"/>'
      '</characteristic>';

  static const String clearPairedDevices =
      '<characteristic type="BluetoothMgr">'
        '<parm name="PairedDeviceAction" value="1"/>'
      '</characteristic>';

  static const String enableBluetooth =
      '<characteristic type="WirelessMgr">'
        '<parm name="BluetoothState" value="1"/>'
      '</characteristic>';

  static const String disableBluetooth =
      '<characteristic type="WirelessMgr">'
        '<parm name="BluetoothState" value="2"/>'
      '</characteristic>';

  static const String enableNfc =
      '<characteristic type="NfcMgr">'
        '<parm name="EnabledNFC" value="1"/>'
      '</characteristic>';

  static const String disableNfc =
      '<characteristic type="NfcMgr">'
        '<parm name="EnabledNFC" value="0"/>'
      '</characteristic>';

  static const String enablePairing =
      '<characteristic type="BluetoothMgr">'
        '<parm name="AllowPairing" value="1"/>'
      '</characteristic>';

  static const String disablePairing =
      '<characteristic type="BluetoothMgr">'
        '<parm name="AllowPairing" value="2"/>'
      '</characteristic>';

  static const String reboot =
      '<characteristic type="PowerMgr">'
        '<parm name="ResetAction" value="4"/>'
      '</characteristic>';

  static const String fullDeviceWipe =
      '<characteristic type="PowerMgr">'
        '<parm name="ResetAction" value="7"/>'
      '</characteristic>';

  static const String resetScanner =
      '<characteristic type="RemoteScannerMgr">'
        '<parm name="Action" value="3"/>'
      '</characteristic>';

  static const String disconnectCurrentScanner =
      '<characteristic type="RemoteScannerMgr">'
        '<parm name="Action" value="5"/>'
      '</characteristic>';

  static const String unpairCurrentScanner =
      '<characteristic type="RemoteScannerMgr">'
        '<parm name="Action" value="6"/>'
      '</characteristic>';

  static const String locateCurrentScanner =
      '<characteristic type="RemoteScannerMgr">'
        '<parm name="Action" value="4"/>'
      '</characteristic>';
}