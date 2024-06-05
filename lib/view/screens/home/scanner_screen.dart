import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:medoptic/Constants/colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({
    super.key,
  });

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late FlutterTts flutterTts;
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void initState() {
    flutterTts = FlutterTts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan MedTag',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Colors.white)),
        backgroundColor: CustomColors.primaryColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Stack(
              children: [
                QRView(
                  key: qrKey,
                  // formatsAllowed: [BarcodeFormat.],
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: CustomColors.primaryColor,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                ),
                Positioned(
                  bottom: 25,
                  left: 10,
                  child: _scannerButton(
                    onPressed: () {
                      controller?.flipCamera();
                    },
                    child: const Icon(
                      Icons.flip_camera_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 25,
                  right: 10,
                  child: _scannerButton(
                    onPressed: () {
                      setState(() {
                        controller?.toggleFlash();
                      });
                    },
                    child: FutureBuilder(
                      future: controller?.getFlashStatus(),
                      builder: (context, snapshot) {
                        return (snapshot.data == true)
                            ? const Icon(
                                Icons.flash_on,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.flash_off,
                                color: Colors.white,
                              );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : const Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  _scannerButton({
    required VoidCallback onPressed,
    required Widget child,
  }) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(CustomColors.contrastColor2),
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(10),
          ),
          shape: MaterialStateProperty.all(
            const CircleBorder(
              side: BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),
          ),
        ),
        onPressed: onPressed,
        child: child);
  }

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      await ttsSpeak(result!.code!);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> ttsSpeak(String text) async {
    debugPrint(text);
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }
}
