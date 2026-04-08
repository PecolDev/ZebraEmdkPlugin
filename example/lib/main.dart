import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:zebra_emdk_plugin/generated/notification.dart';
import 'package:zebra_emdk_plugin/generated/scanner_config.dart';
import 'package:zebra_emdk_plugin_example/pairing_code_dialog.dart';
import 'package:zebra_emdk_plugin_example/zebra_emdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EMDK Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'EMDK Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ZebraEMDK emdk;

  @override
  void initState() {
    super.initState();
    
    emdk = ZebraEMDK();
    
    emdk.initialize();

    emdk.onDataRead.listen((data) async {
      log('[EMDK_APP] Scan Event Received! Result: ${data?.result?.value}');
      
      if (data?.scanData != null && data!.scanData!.isNotEmpty) {
        for (var i = 0; i < data.scanData!.length; i++) {
          final scanData = data.scanData![i];
          final rawBytesLength = scanData.rawData?.length ?? 0;
          
          log('[EMDK_APP]   -> Barcode [${i + 1}]: ${scanData.data}');
          log('[EMDK_APP]   -> Type: ${scanData.labelType?.value} | Raw Bytes: $rawBytesLength bytes');
        }
      } else {
        log('[EMDK_APP]   -> No barcode data found in the payload.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                var a = await emdk.getPeripheralDeviceInfo();

                if(a == ""){
                  
                }
              },
              child: const Text('Get peripheral device info'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var a = await emdk.getPeripheralBatteryInfo();

                if(a == ""){

                }
              },
              child: const Text('Get peripheral battery info'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => PairingCodeDialog(),
                );
              },
              child: const Text('Open pairing dialog'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: (){
                emdk.setScannerConfig(
                  ScannerConfig(
                    ngSimulScanParams: NGSimulScanParams(
                      ngSimulScanMode: NGSimulScanMode.none
                    ),

                  )
                );
              },
              child: const Text('Single barcode config'),
            ),
            ElevatedButton(
              onPressed: (){
                emdk.setScannerConfig(
                  ScannerConfig(
                    ngSimulScanParams: NGSimulScanParams(
                      ngSimulScanMode: NGSimulScanMode.multiBarcode,
                      multiBarcodeParams: NGSimulScanMultiBarcodeParams(
                        barcodeCount: 2
                      )
                    )
                  )
                );
              },
              child: const Text('Multi barcode config'),
            ),
            ElevatedButton(
              onPressed: (){
                emdk.notifyDevice(
                  NotificationCommand(
                    vibrate: NotificationVibrateParams(time: 2000),
                    led: NotificationLEDParams(color: 0xFF0000, onTime: 200, offTime: 200, repeatCount: 3),
                    beep: NotificationBeepParams(
                      pattern: [
                        NotificationBeep(time: 100, frequency: 988),
                        NotificationBeep(time: 100, frequency: 0),
                        NotificationBeep(time: 100, frequency: 784),
                        NotificationBeep(time: 100, frequency: 0),
                        NotificationBeep(time: 100, frequency: 988),
                        NotificationBeep(time: 100, frequency: 0),
                        NotificationBeep(time: 300, frequency: 1047),
                      ]
                    )
                  )
                );
              },
              child: const Text('Notify'),
            )
          ],
        ),
      ),
    );
  }
}
