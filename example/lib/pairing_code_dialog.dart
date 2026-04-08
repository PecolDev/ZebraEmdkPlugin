import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zebra_emdk_plugin_example/zebra_emdk.dart';

class PairingCodeDialog extends StatelessWidget {
  const PairingCodeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pairing Code'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FutureBuilder<String?>(
            future: ZebraEMDK().getPairingCode(),
            builder: (context, snapshot) {
              if(snapshot.hasData && snapshot.data != null){
                return SvgPicture.string(
                  Barcode.code128(escapes: true).toSvg(snapshot.data!, drawText: false)
                );
              }

              return const CircularProgressIndicator();
            },
          )
        ]
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}