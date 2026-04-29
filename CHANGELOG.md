## 0.3.0

**New features**

* **Hardware key listener** (`KeyEventManager` / `KeyEventHandler`): Listen to physical button presses on Zebra devices via the MX `KeyMappingMgr` CSP.
  * `EmdkManager.keyEventManager` — new lazy getter that returns the `KeyEventManager`.
  * `KeyEventManager.onKeyDown` — stream that emits a `KeyIdentifier` whenever a mapped key is pressed.
  * `ProfileManager.addKeyListener(KeyIdentifier)` — maps a key to send a `KEY_DOWN_EVENT` broadcast to the app (fire-and-forget, result on `onData`).
  * `ProfileManager.resetAllKeyMappings()` — resets all key mappings to factory defaults (fire-and-forget).
  * `KeyIdentifier` — new enum covering all ~100 Zebra MX key identifiers (number keys, alpha keys, function keys, P-buttons, trigger buttons, volume, navigation, and device-specific keys) with exact MX XML string values.

* **`onDetachedFromEngine` cleanup**: `ZebraEmdkPlugin.onDetachedFromEngine` now calls `emdkManagerHandler.cleanup()`, which disposes the `KeyEventHandler` broadcast receiver and releases the EMDK manager. This prevents `ServiceConnectionLeaked` and `IntentReceiverLeaked` logcat errors on hot restart or Activity destroy.

* **Application context fix**: `EmdkManagerHandler.initializeHandler` now calls `context.applicationContext` instead of using the raw Activity context, preventing EMDK service binding and BroadcastReceiver from being tied to the Activity lifecycle.

**Improvements**

* **Profile queue deadlock fix** (`ProfileManagerHandler`): `executeNextProfile` now captures the next `pendingProfiles` entry and sets the lock state inside `synchronized`, then calls `processProfileAsync` *outside* the lock. Previously, if the EMDK callback fired on the same thread, it could deadlock on the same monitor.

* **Profile `onData` ordering fix**: The `onData` event is now fired *before* the completed profile is removed from the queue and the next one is dispatched. This guarantees that listeners always receive the result of the profile that just ran before the next profile begins.

---

## 0.2.1

**Improvements**

* **Native error propagation**: All four Kotlin handler `onMethodCall` blocks are now wrapped in a top-level `try/catch`. Unhandled EMDK exceptions (`ScannerException`, `NotificationException`) and unexpected Java/Kotlin exceptions are no longer swallowed silently — they are forwarded to the Dart side as typed `PlatformException` errors with structured `code` and `details`.

* **Typed Dart exceptions from `ZepServiceBase.invokeMethod`**: Instead of returning `null` on failure, `invokeMethod` now decodes the incoming `PlatformException` code and rethrows the matching Dart exception:

  | Native exception        | `code`                   | Dart exception          |
  |-------------------------|--------------------------|-------------------------|
  | `ScannerException`      | `SCANNER_EXCEPTION`      | `ScannerException`      |
  | `NotificationException` | `NOTIFICATION_EXCEPTION` | `NotificationException` |
  | EMDK feature failure    | `EMDK_EXCEPTION`         | `EMDKException`         |
  | Any other exception     | `NATIVE_EXCEPTION`       | `PlatformException`     |

* **New exception classes**:
  * `EMDKException` — thrown when the EMDK manager fails to open or a feature instance cannot be acquired. Carries an optional `EMDKResults` payload.
  * `NotificationException` — thrown when a notification device operation fails (enable, notify). Carries a `NotificationResults` result code.

* **EventChannel error guard**: `ZepServiceBase` now attaches a `.handleError()` handler to the raw event stream so unhandled EventChannel errors are logged instead of crashing the stream.

* **`initScanner` / `initDevice` cleanup on failure**: In the example `Emdk` wrapper, calls to `initScanner` and `initDevice` now catch exceptions and call `deinitScanner` / `deinitDevice` to ensure the native side is always left in a clean state.

---

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
