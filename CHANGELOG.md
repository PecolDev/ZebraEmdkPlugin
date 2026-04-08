## 0.1.1

* Shortened .yaml description

## 0.1.0

* Initial release of `zebra_emdk_plugin`.
* EMDK Manager: initialize and listen for open/close events.
* Barcode Manager: enumerate supported scanners, select scanner by friendly name, listen for connection changes.
* Scanner: initialize, enable/disable read, get/set configuration (with full decoder params), listen for scan data and status events.
* Notification Manager: enumerate supported notification devices, select device by friendly name.
* Notification Device: initialize, trigger LED, beep, and vibrate notifications.
* Profile Manager: initialize, apply profiles asynchronously via `processProfile`, and listen for results.
* OEM Info: read Bluetooth MAC, serial number, product model, Wi-Fi MAC, peripheral battery info, and peripheral device info.
