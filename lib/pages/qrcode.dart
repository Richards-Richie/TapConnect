import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:simple_app/main.dart';

class QRCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppStateManager.of(context);

    // Combine details into a single string for QR code generation
    String qrData =
        'Name: ${appState.name}\nPhone: ${appState.phoneNumber}\nEmail: ${appState.email}';

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        foregroundColor: const Color.fromARGB(255, 239, 236, 236),
      ),
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: const Color.fromARGB(
                  255, 239, 236, 236), // Background color for the QR code
              padding: EdgeInsets.all(16), // Add padding for aesthetics
              child: QrImageView(
                data: qrData, // QR code data
                size: 250, // Size of the QR code
                version:
                    QrVersions.auto, // Automatically adjust QR code version
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Scan this QR Code",
              style: TextStyle(
                  color: Color.fromARGB(255, 239, 236, 236), fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
