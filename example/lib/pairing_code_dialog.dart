import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zebra_emdk_plugin_example/emdk.dart';

class PairingCodeDialog extends StatelessWidget {
  const PairingCodeDialog({super.key});

  // Barcode render dimensions. The SVG will fill the white container below.
  static const double _barcodeWidth = 320;
  static const double _barcodeHeight = 100;

  // Quiet zone: white padding on all sides so the scanner can locate edges.
  static const double _quietZone = 24;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // Wider than a default AlertDialog so the barcode has room.
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Pairing Code',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              'Scan this barcode with the peripheral scanner to pair.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withAlpha(127),
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder<String?>(
              future: Emdk().getPairingCode(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: _barcodeHeight + _quietZone * 2,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (snapshot.hasError || snapshot.data == null) {
                  return SizedBox(
                    height: _barcodeHeight + _quietZone * 2,
                    child: Center(
                      child: Text(
                        'Could not generate pairing code.',
                        style: TextStyle(color: Colors.red.shade300, fontSize: 13),
                      ),
                    ),
                  );
                }

                final svg = Barcode.code128(escapes: true).toSvg(
                  snapshot.data!,
                  width: _barcodeWidth,
                  height: _barcodeHeight,
                  drawText: false,
                  // Explicitly black bars so they don't inherit any theme color.
                  color: 0xFF000000,
                );

                return Container(
                  // White background with the quiet zone baked in as padding.
                  // This guarantees high contrast regardless of dialog theme.
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(_quietZone),
                  child: SvgPicture.string(
                    svg,
                    width: _barcodeWidth,
                    height: _barcodeHeight,
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}