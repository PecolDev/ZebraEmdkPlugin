# zebra_emdk_plugin

A Flutter plugin for **Zebra Android devices** that wraps the [Zebra EMDK SDK](https://techdocs.zebra.com/emdk-for-android/).

Supports barcode scanning, scanner configuration (full decoder params), profile management (MX/StageNow), LED/beep/vibrate notifications, and OEM device info queries.

> **⚠️ Important:** This plugin only works on Zebra Android devices. It will not function on standard Android devices.

---

## Features

| Feature | Description |
|---------|-------------|
| **EMDK Manager** | Initialize the EMDK service and listen for open/close events |
| **Barcode Manager** | Enumerate scanners, select by friendly name, listen for connection changes |
| **Scanner** | Enable/disable read, get/set full scanner config (decoder params), scan data events |
| **Notification Manager** | Enumerate notification devices (LED/beep/vibrate) |
| **Notification Device** | Trigger LED, beep, and vibrate notifications |
| **Profile Manager** | Apply MX profiles asynchronously and receive results |
| **OEM Info** | Read Bluetooth MAC, serial number, product model, Wi-Fi MAC, peripheral battery/device info |

---

## Setup

### 1. Add the Zebra EMDK Maven repository

In your **app's** `android/build.gradle` (or `settings.gradle` if using version catalogs), add:

```groovy
repositories {
    // ... other repos
    maven {
        url 'https://zebratech.jfrog.io/artifactory/EMDK-Android/'
    }
}
```

### 2. Add the dependency

```yaml
dependencies:
  zebra_emdk_plugin: ^0.1.0
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

### Initialize EMDK and open a barcode scanner

```dart
import 'package:zebra_emdk_plugin/zebra_emdk_plugin.dart';

// 1. Start EMDK Manager
final emdkService = EmdkManagerService();
await emdkService.initialize();

// 2. Once EMDK opens, initialize the Barcode Manager
final barcodeService = BarcodeManagerService();
await barcodeService.initialize();

// 3. Get available scanners and pick one
final scanners = await barcodeService.getSupportedScanners();
await barcodeService.setScannerTypeByFriendlyName(scanners.first.friendlyName);

// 4. Initialize the scanner and listen for scan data
final scannerService = ScannerService();
await scannerService.initialize();
await scannerService.enableRead();

scannerService.onData.listen((scanData) {
  print('Scanned: ${scanData.data}');
});
```

### Trigger a notification (beep + LED)

```dart
final notificationService = NotificationManagerService();
await notificationService.initialize();
await notificationService.setNotificationDeviceByFriendlyName('DEFAULT');

final deviceService = NotificationDeviceService();
await deviceService.initialize();
await deviceService.notify(
  beep: BeepCommand(pattern: [Beep(time: 100, frequency: 2500)]),
  led: LedCommand(color: 3, onTime: 100, offTime: 0, repeatCount: 1),
);
```

### Read OEM device info

```dart
final oemInfo = OemInfoService();
final serial = await oemInfo.getSerialNumber();
final btMac = await oemInfo.getBluetoothMac();
print('Device: $serial, BT: $btMac');
```

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
