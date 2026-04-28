## 0.2.0

**Breaking changes**

* **Android — modular handler architecture**: The monolithic `ZebraEmdkPlugin.kt` (single class implementing all EMDK features) has been replaced with dedicated handler classes, each owning its own MethodChannel and EventChannel:
  * `EmdkManagerHandler` — EMDK lifecycle
  * `BarcodeManagerHandler` — scanner discovery, read control, config, and data events
  * `NotificationManagerHandler` — notification device discovery and triggering
  * `ProfileManagerHandler` — MX profile processing and OEM content-provider queries
  * `Extensions.kt` — shared Kotlin helpers
  * `ZebraEmdkPlugin.kt` is now a thin entry-point that delegates to `EmdkManagerHandler`

* **Dart — service layer renamed and restructured**: All service files have been renamed and the channel naming convention changed:
  * `emdk_manager_service.dart` → `emdk_manager.dart` (class `EmdkManagerService` → `EmdkManager`)
  * `barcode_manager_service.dart` → `barcode_manager.dart` (class `BarcodeManagerService` → `BarcodeManager`)
  * `notification_manager_service.dart` → `notification_manager.dart` (class `NotificationManagerService` → `NotificationManager`)
  * `profile_manager_service.dart` → `profile_manager.dart` (class `ProfileManagerService` → `ProfileManager`)
  * `scanner_service.dart` removed — scanner operations (`enableRead`, `disableRead`, `initScanner`, `deinitScanner`, `getConfig`, `setConfig`, `onStatus`, `onData`) now live directly on `BarcodeManager`
  * `notification_device_service.dart` removed — notification device operations (`initDevice`, `deinitDevice`, `notify`, `getDeviceInfo`) now live directly on `NotificationManager`
  * `oem_info_service.dart` removed — OEM queries now exposed through `ProfileManager.resolveCursorUri(uri)` and `ProfileManager.requestServicePermission(uri)`
  * `platform_service_base.dart` replaced by `zep_service_base.dart` (`ZepServiceBase`) with new channel naming: `zep/methods/<handler>` and `zep/events/<handler>`

* **`BarcodeManager` API changes**:
  * `setScannerTypeByFriendlyName(name)` → `initScanner(name)`
  * `dispose()` removed — use `deinitScanner()`
  * New method: `getConnectedScanners()` — returns only currently-connected scanners
  * `onStatus` and `onData` streams moved from `ScannerService` to `BarcodeManager`

* **`NotificationManager` API changes**:
  * `setNotificationDeviceByFriendlyName(name)` → `initDevice(name)`
  * `dispose()` removed — use `deinitDevice()`
  * `getNotificationDeviceInfo()` → `getDeviceInfo()`
  * New method: `getConnectedDevices()` — returns only currently-connected notification devices
  * `notify(command)` moved from `NotificationDeviceService` to `NotificationManager`

* **`ProfileManager` API changes**:
  * `processProfileAsync(profileName, xmlData)` → `processProfileAsync(characteristics)` — takes the XML characteristics string directly; the profile wrapper and name are now generated internally on the native side
  * New method: `requestServicePermission(uri)` — explicitly request access to a content-provider URI
  * New method: `resolveCursorUri(uri)` — query any Zebra OEMinfo content-provider URI directly

**New features**

* **Profile processing queue** (`ProfileManagerHandler`): MX profiles are now processed through a serialised `LinkedHashMap` queue. Concurrent `processProfileAsync` calls no longer race — each profile waits for the previous one to finish before being submitted to `processProfileAsync` on the native EMDK.

**Example app**

* Renamed from `ZebraEMDK` / `zebra_emdk.dart` to `Emdk` / `emdk.dart`
* EMDK now auto-initialises in `initState()` instead of requiring a manual button press
* Dark-mode UI redesign with Material 3
* Dispose is now async (`_disposeEmdk`)
* `onProfileData` stream is now listened to in the example
* `content_uris.dart` and `mx_profiles.dart` correctly moved from the plugin package into the example app

---

## 0.1.0

* Initial release of `zebra_emdk_plugin`.
* EMDK Manager: initialize and listen for open/close events.
* Barcode Manager: enumerate supported scanners, select scanner by friendly name, listen for connection changes.
* Scanner: initialize, enable/disable read, get/set configuration (with full decoder params), listen for scan data and status events.
* Notification Manager: enumerate supported notification devices, select device by friendly name.
* Notification Device: initialize, trigger LED, beep, and vibrate notifications.
* Profile Manager: initialize, apply profiles asynchronously via `processProfile`, and listen for results.
* OEM Info: read Bluetooth MAC, serial number, product model, Wi-Fi MAC, peripheral battery info, and peripheral device info.
