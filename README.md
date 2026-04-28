# zebra_emdk_plugin

A Flutter plugin for **Zebra Android devices** that wraps the [Zebra EMDK SDK](https://techdocs.zebra.com/emdk-for-android/).

Supports barcode scanning, scanner configuration (full decoder params), profile management (MX/StageNow), LED/beep/vibrate notifications, and OEM device info queries.

> **⚠️ Important:** This plugin only works on Zebra Android devices. It will not function on standard Android devices.

---

## Features

| Feature | Description |
|---------|-------------|
| **EMDK Manager** | Initialize the EMDK service and listen for open/close events |
| **Barcode Manager** | Enumerate/filter scanners, init by friendly name, scanner config, read control, scan data & status events |
| **Notification Manager** | Enumerate/filter notification devices, trigger LED, beep, and vibrate notifications |
| **Profile Manager** | Apply MX profiles asynchronously with a serialised queue, query OEM content-provider URIs |

---

## Setup

### 1. Add the Zebra EMDK Maven repository

In your **app's** `android/build.gradle.kts`, add:

```kotlin
allprojects {
    repositories {
        google()
        mavenCentral()
        maven {
            url = uri("https://zebratech.jfrog.io/artifactory/EMDK-Android/")
        }
    }
}
```

### 2. Add the dependency

```yaml
dependencies:
  zebra_emdk_plugin: ^0.2.0
```

### 3. Update AndroidManifest.xml

Add the following to your app's `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest ...>
    <!-- Required EMDK permissions -->
    <uses-permission android:name="com.symbol.emdk.permission.EMDK" />
    <uses-permission android:name="com.zebra.provider.READ" />

    <!-- Required for Android 11+ package visibility -->
    <queries>
        <package android:name="com.symbol.emdk.emdkservice" />
        <package android:name="com.zebra.zebracontentprovider" />
        <provider android:authorities="oem_info" />
    </queries>

    <application ...>
        <uses-library android:name="com.symbol.emdk" android:required="false" />
        ...
    </application>
</manifest>
```

---

## Usage

### Initialize EMDK and scan a barcode

```dart
import 'package:zebra_emdk_plugin/zebra_emdk_plugin.dart';

// 1. Create the EMDK Manager and start listening for the open event
final emdk = EmdkManager();
emdk.onOpened.listen((_) async {
  // 2. EMDK is ready — initialize the Barcode Manager
  final bm = emdk.barcodeManager;

  // 3. Get all connected scanners and init the first one
  final scanners = await bm.getConnectedScanners();
  if (scanners != null && scanners.isNotEmpty) {
    await bm.initScanner(scanners.first.friendlyName!);
  }

  // 4. Listen for scan data and start reading
  bm.onData.listen((collection) {
    final barcode = collection?.scanData?.firstOrNull?.data;
    print('Scanned: $barcode');
  });

  await bm.enableRead();
});

// 5. Request the EMDK Manager from the OS
await emdk.initialize();
```

### Trigger a notification (beep + LED + vibrate)

```dart
final nm = emdk.notificationManager;

// Init the first connected notification device
final devices = await nm.getConnectedDevices();
if (devices != null && devices.isNotEmpty) {
  await nm.initDevice(devices.first.friendlyName!);
}

await nm.notify(
  NotificationCommand(
    beep: NotificationBeepParams(pattern: [
      NotificationBeep(time: 100, frequency: 2500),
    ]),
    led: NotificationLEDParams(
      color: 0x00FF00, onTime: 200, offTime: 200, repeatCount: 3,
    ),
    vibrate: NotificationVibrateParams(time: 500),
  ),
);
```

### Apply an MX profile

```dart
final pm = emdk.profileManager;

pm.onData.listen((result) {
  print('Profile result: ${result?.result?.statusCode?.value}');
});

// Pass only the inner <characteristic> block(s) — the plugin wraps them automatically
pm.processProfileAsync('''
  <characteristic type="PowerMgr">
    <parm name="ResetAction" value="1"/>
  </characteristic>
''');
```

### Query OEM device info

```dart
final pm = emdk.profileManager;

// Read Bluetooth MAC (Zebra OEMinfo content provider)
final btMac = await pm.resolveCursorUri('content://oem_info/oem.zebra.secure/bt_mac');
final serial = await pm.resolveCursorUri('content://oem_info/oem.zebra.secure/build_serial');
final model  = await pm.resolveCursorUri('content://oem_info/oem.zebra.secure/ro_product_model');
final wifiMac = await pm.resolveCursorUri('content://oem_info/oem.zebra.secure/wifi_mac');

print('BT: $btMac | Serial: $serial | Model: $model');
```

### Get scanner configuration

```dart
final config = await emdk.barcodeManager.getConfig();

// Modify and apply
final updated = ScannerConfig(
  ngSimulScanParams: NGSimulScanParams(
    ngSimulScanMode: NGSimulScanMode.multiBarcode,
    multiBarcodeParams: NGSimulScanMultiBarcodeParams(barcodeCount: 2),
  ),
);
await emdk.barcodeManager.setConfig(updated);
```

---

## API Reference

### `EmdkManager`

| Member | Description |
|--------|-------------|
| `initialize()` | Requests the EMDK Manager from the OS |
| `dispose()` | Releases all EMDK resources |
| `barcodeManager` | Lazy getter for `BarcodeManager` |
| `notificationManager` | Lazy getter for `NotificationManager` |
| `profileManager` | Lazy getter for `ProfileManager` |
| `onOpened` | Stream fired when EMDK is ready |
| `onClosed` | Stream fired when EMDK is closed |

### `BarcodeManager`

| Member | Description |
|--------|-------------|
| `getSupportedScanners()` | All known scanners (connected or not) |
| `getConnectedScanners()` | Currently-connected scanners only |
| `initScanner(friendlyName)` | Initializes a scanner by friendly name |
| `deinitScanner()` | Releases the active scanner |
| `getScannerInfo()` | Info about the active scanner |
| `enableRead()` | Arms the scanner to read |
| `disableRead()` | Cancels a pending read |
| `getConfig()` | Returns the current `ScannerConfig` |
| `setConfig(config)` | Applies a `ScannerConfig` |
| `onConnectionChange` | Stream of scanner connect/disconnect events |
| `onStatus` | Stream of scanner state changes |
| `onData` | Stream of `ScanDataCollection` scan results |

### `NotificationManager`

| Member | Description |
|--------|-------------|
| `getSupportedDevices()` | All known notification devices |
| `getConnectedDevices()` | Currently-connected notification devices only |
| `initDevice(friendlyName)` | Enables a notification device by friendly name |
| `deinitDevice()` | Disables the active notification device |
| `getDeviceInfo()` | Info about the active notification device |
| `notify(command)` | Triggers a `NotificationCommand` (LED/Beep/Vibrate) |

### `ProfileManager`

| Member | Description |
|--------|-------------|
| `processProfileAsync(characteristics)` | Queues an MX XML characteristics block for processing |
| `requestServicePermission(uri)` | Requests an AccessMgr content-provider permission |
| `resolveCursorUri(uri)` | Reads a single-value Zebra OEMinfo URI |
| `onData` | Stream of `ProfileResultData` results |

---

## Platform Support

| Platform | Supported |
|----------|-----------|
| Android (Zebra devices) | ✅ |
| iOS | ❌ |
| Web | ❌ |
| Windows / macOS / Linux | ❌ |

Minimum Android SDK: **24 (Android 7.0)**

---

## EMDK Version

This plugin was built against **EMDK 11.0.134**.

---

## License

MIT — see [LICENSE](LICENSE).
