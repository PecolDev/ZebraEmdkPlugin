import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:zebra_emdk_plugin_example/emdk.dart';
import 'package:zebra_emdk_plugin/generated/notification.dart';
import 'package:zebra_emdk_plugin/generated/scanner_config.dart';
import 'package:zebra_emdk_plugin_example/pairing_code_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EMDK Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00C8FF),
          brightness: Brightness.dark,
        ),
        fontFamily: 'monospace',
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Emdk? emdk;
  bool _emdkReady = false;
  String _statusMessage = 'Initializing EMDK…';

  static const _accentColor = Color(0xFF00C8FF);
  static const _dangerColor = Color(0xFFFF4D4D);
  static const _surfaceColor = Color(0xFF1E2128);
  static const _cardColor = Color(0xFF252930);

  @override
  void initState() {
    super.initState();
    _initializeEmdk();
  }

  @override
  void dispose() {
    super.dispose();
    _disposeEmdk();
  }

  Future<void> _initializeEmdk() async {
    setState(() {
      _emdkReady = false;
      _statusMessage = 'Initializing EMDK…';
    });

    emdk = Emdk();
    await emdk!.initialize();

    emdk!.onDataRead.listen((data) async {
      log('[EMDK_APP] Scan Event Received! Result: ${data?.result?.value}');
      if (data?.scanData != null && data!.scanData!.isNotEmpty) {
        for (var i = 0; i < data.scanData!.length; i++) {
          final scanData = data.scanData![i];
          final rawBytesLength = scanData.rawData?.length ?? 0;
          log('[EMDK_APP]   -> Barcode [${i + 1}]: ${scanData.data}');
          log('[EMDK_APP]   -> Type: ${scanData.labelType?.value} | Raw: $rawBytesLength bytes');
        }
      } else {
        log('[EMDK_APP]   -> No barcode data found in the payload.');
      }
    });

    emdk!.onProfileData.listen((data) {
      log('[EMDK_APP] Profile: ${data?.profileName}');
      log('[EMDK_APP] Profile Status: ${data?.result?.statusString}');
      log('[EMDK_APP] Profile Code: ${data?.result?.statusCode?.value}');
      log('[EMDK_APP] -------------------------------------------------------------');
    });

    emdk!.onKeyDown.listen((identifier) {
      log('[EMDK_APP] Key Down: ${identifier?.value}');
      log('[EMDK_APP] -------------------------------------------------------------');
    });

    setState(() {
      _emdkReady = true;
      _statusMessage = 'EMDK Ready';
    });
  }

  Future<void> _disposeEmdk() async {
    await emdk?.dispose();
    emdk = null;
    if (mounted) {
      setState(() {
        _emdkReady = false;
        _statusMessage = 'EMDK Disposed';
      });
    }
  }

  void _run(VoidCallback action) {
    if (emdk == null) return;
    action();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _surfaceColor,
      appBar: _buildAppBar(),
      body: _emdkReady
          ? _buildBody()
          : _buildLoadingState(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _cardColor,
      elevation: 0,
      title: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _emdkReady ? Colors.greenAccent : Colors.orange,
              boxShadow: [
                BoxShadow(
                  color: (_emdkReady ? Colors.greenAccent : Colors.orange).withAlpha(153),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Zebra EMDK Demo',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: Colors.white,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: TextButton.icon(
            onPressed: () async {
              await _disposeEmdk();
              await _initializeEmdk();
            },
            icon: const Icon(Icons.refresh_rounded, size: 18, color: _accentColor),
            label: const Text(
              'Restart',
              style: TextStyle(color: _accentColor, fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              color: _accentColor,
              strokeWidth: 2.5,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            _statusMessage,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        _buildActionTile(
          label: 'Pairing QR Code',
          subtitle: 'Bluetooth SSI barcode for pairing the peripheral',
          icon: Icons.qr_code_2_rounded,
          onTap: () => showDialog(
            context: context,
            builder: (context) => const PairingCodeDialog(),
          ),
        ),
        _buildSection(
          icon: Icons.phonelink_setup,
          title: 'Remote Device',
          children: [
            _buildButtonRow([
              _buildChip(label: 'Reset', icon: Icons.restart_alt_rounded,
                  onTap: () => _run(emdk!.resetScanner)),

              _buildChip(label: 'Disconnect', icon: Icons.link_off_rounded,
                  onTap: () => _run(emdk!.disconnectCurrentScanner)),

              _buildChip(label: 'Unpair', icon: Icons.bluetooth_disabled_rounded,
                  onTap: () => _run(emdk!.unpairCurrentScanner)),

              _buildChip(label: 'Locate', icon: Icons.lightbulb_rounded,
                  onTap: () => _run(emdk!.locateCurrentScanner)),

              _buildChip(label: 'Battery Info', icon: Icons.battery_charging_full_rounded,
                  onTap: () async {
                    final info = await emdk!.getPeripheralBatteryInfo();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: _cardColor,
                          content: Text(
                            info != null && info.isNotEmpty ? info : 'No data returned',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                      );
                    }
                  }),

              _buildChip(label: 'Test Notification', icon: Icons.sensors_rounded,
                  onTap: () => _run(() => emdk!.notifyDevice(
                    NotificationCommand(
                      vibrate: NotificationVibrateParams(time: 2000),
                      led: NotificationLEDParams(
                        color: 0xFF0000, onTime: 200, offTime: 200, repeatCount: 3),
                      beep: NotificationBeepParams(pattern: [
                        NotificationBeep(time: 100, frequency: 988),
                        NotificationBeep(time: 100, frequency: 0),
                        NotificationBeep(time: 100, frequency: 784),
                        NotificationBeep(time: 100, frequency: 0),
                        NotificationBeep(time: 100, frequency: 988),
                        NotificationBeep(time: 100, frequency: 0),
                        NotificationBeep(time: 300, frequency: 1047),
                      ]),
                    )
                  ))),
            ]),
            const SizedBox(height: 10),
            _buildToggleRow(
              leftLabel: 'Single Barcode',
              rightLabel: 'Multi Barcode',
              leftIcon: Icons.crop_square_rounded,
              rightIcon: Icons.grid_view_rounded,
              onLeft: () => _run(() => emdk!.setScannerConfig(
                ScannerConfig(
                  ngSimulScanParams: NGSimulScanParams(
                    ngSimulScanMode: NGSimulScanMode.none,
                  ),
                ),
              )),
              onRight: () => _run(() => emdk!.setScannerConfig(
                ScannerConfig(
                  ngSimulScanParams: NGSimulScanParams(
                    ngSimulScanMode: NGSimulScanMode.multiBarcode,
                    multiBarcodeParams:
                        NGSimulScanMultiBarcodeParams(barcodeCount: 2),
                  ),
                ),
              )),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildSection(
          icon: Icons.phonelink_setup_rounded,
          title: 'This device',
          children: [
            _buildButtonRow([
              _buildChip(label: 'Clear all paired devices', icon: Icons.cleaning_services_rounded,
                  onTap: () => _run(emdk!.clearPairedDevices)),
            ]),
            const SizedBox(height: 10),
            _buildToggleRow(
              leftLabel: 'Enable Bluetooth',
              rightLabel: 'Disable Bluetooth',
              leftIcon: Icons.bluetooth_rounded,
              rightIcon: Icons.bluetooth_disabled_rounded,
              onLeft: () => _run(emdk!.enableBluetooth),
              onRight: () => _run(emdk!.disableBluetooth),
            ),
            const SizedBox(height: 10),
            _buildToggleRow(
              leftLabel: 'Enable NFC',
              rightLabel: 'Disable NFC',
              leftIcon: Icons.nfc_rounded,
              rightIcon: Icons.nfc_rounded,
              onLeft: () => _run(emdk!.enableNfc),
              onRight: () => _run(emdk!.disableNfc),
            ),
            const SizedBox(height: 10),
            _buildToggleRow(
              leftLabel: 'Apply Restrictions',
              rightLabel: 'Remove Restrictions',
              leftIcon: Icons.lock_rounded,
              rightIcon: Icons.lock_open_rounded,
              onLeft: () => _run(emdk!.addRestrictions),
              onRight: () => _run(emdk!.removeRestrictions),
            ),
            const SizedBox(height: 10),
            _buildActionTile(
              label: 'Reboot Device',
              subtitle: 'Performs a soft reboot',
              icon: Icons.restart_alt_rounded,
              color: Colors.orange,
              onTap: () => _showConfirmDialog(
                title: 'Reboot Device?',
                message: 'This will reboot the device immediately.',
                onConfirm: () => _run(emdk!.rebootDevice),
              ),
            ),
            _buildActionTile(
              label: 'Full Device Wipe',
              subtitle: 'Erases all data',
              icon: Icons.delete_forever_rounded,
              color: _dangerColor,
              onTap: () => _showConfirmDialog(
                title: 'Full Device Wipe?',
                message:
                    'All data will be erased.',
                onConfirm: () => _run(emdk!.fullDeviceWipe),
                isDanger: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─── UI Components ──────────────────────────────────────────────────────────

  Widget _buildSection({
    required IconData icon,
    required String title,
    required List<Widget> children,
    Color color = _accentColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withAlpha(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: color.withAlpha(30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 16, color: color),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: color,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.white.withAlpha(15), height: 1),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleRow({
    required String leftLabel,
    required String rightLabel,
    required IconData leftIcon,
    required IconData rightIcon,
    required VoidCallback onLeft,
    required VoidCallback onRight,
  }) {
    return Row(
      children: [
        Expanded(
          child: _buildOutlinedBtn(
            label: leftLabel,
            icon: leftIcon,
            onTap: onLeft,
            color: Colors.greenAccent,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildOutlinedBtn(
            label: rightLabel,
            icon: rightIcon,
            onTap: onRight,
            color: Colors.redAccent,
          ),
        ),
      ],
    );
  }

  Widget _buildOutlinedBtn({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    Color color = _accentColor,
  }) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 15, color: color),
      label: Text(
        label,
        style: TextStyle(fontSize: 12, color: color),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        side: BorderSide(color: color.withAlpha(76)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        foregroundColor: color,
      ),
    );
  }

  Widget _buildButtonRow(List<Widget> chips) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: chips,
    );
  }

  Widget _buildChip({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    Color color = _accentColor,
  }) {
    return ActionChip(
      onPressed: onTap,
      avatar: Icon(icon, size: 15, color: color),
      label: Text(label, style: TextStyle(fontSize: 12, color: color)),
      backgroundColor: color.withAlpha(20),
      side: BorderSide(color: color.withAlpha(64)),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  Widget _buildActionTile({
    required String label,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    Color color = _accentColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: color.withAlpha(15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withAlpha(38)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withAlpha(115),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                color: Colors.white.withAlpha(64), size: 18),
          ],
        ),
      ),
    );
  }

  void _showConfirmDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    bool isDanger = false,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title,
            style: const TextStyle(color: Colors.white, fontSize: 16)),
        content: Text(message,
            style: TextStyle(color: Colors.white.withAlpha(153), fontSize: 13)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              onConfirm();
            },
            child: Text(
              'Confirm',
              style: TextStyle(
                  color: isDanger ? _dangerColor : _accentColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
