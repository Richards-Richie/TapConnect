import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'savecontact.dart'; // Import SaveContactPage

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String name = "";
  String phoneNumber = "";
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        foregroundColor: Color.fromARGB(255, 239, 236, 236),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromARGB(255, 239, 236, 236), width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: MobileScanner(
                  controller: MobileScannerController(
                      detectionSpeed: DetectionSpeed.noDuplicates),
                  onDetect: (BarcodeCapture barcode) {
                    if (barcode.barcodes.isNotEmpty) {
                      final String code = barcode.barcodes.first.rawValue ?? '';

                      // Use RegExp to split by newline, semicolon, or comma
                      final contactInfo = code.split(RegExp(r'[\n,;]+'));
                      print(contactInfo); // Check how the data is being split

                      if (contactInfo.length > 0) name = contactInfo[0].trim();
                      if (contactInfo.length > 1)
                        phoneNumber = contactInfo[1].trim();
                      if (contactInfo.length > 2) email = contactInfo[2].trim();

                      print(email); // Verify email value
                      setState(() {});

                      // Navigate to SaveContactPage with separate data
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SaveContactPage(
                            name: name,
                            phoneNumber: phoneNumber,
                            email: email,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          if (name.isNotEmpty)
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Scanned Data: $name, $phoneNumber, $email',
                    style: TextStyle(
                        color: Color.fromARGB(255, 239, 236, 236),
                        fontSize: 20),
                  ),
                ),
              ),
            ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
    );
  }
}
