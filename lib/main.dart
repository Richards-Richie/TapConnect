import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_app/pages/details.dart';
import 'package:simple_app/pages/qrcode.dart';
import 'package:simple_app/pages/scanner.dart'; // Import the scanner page

void main() {
  runApp(
    AppStateManager(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppStateManager(
        child: ScaffoldWithContext(),
      ),
    );
  }
}

class AppStateManager extends StatefulWidget {
  final Widget child;
  const AppStateManager({super.key, required this.child});

  @override
  AppStateManagerState createState() => AppStateManagerState();

  static AppStateManagerState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_AppStateProvider>()!
        .data;
  }
}

class AppStateManagerState extends State<AppStateManager> {
  String name = '';
  String phoneNumber = '';
  String email = '';

  void updateDetails(String newName, String newPhoneNumber, String newEmail) {
    setState(() {
      name = newName;
      phoneNumber = newPhoneNumber;
      email = newEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _AppStateProvider(
      data: this,
      child: widget.child,
    );
  }
}

class _AppStateProvider extends InheritedWidget {
  final AppStateManagerState data;
  const _AppStateProvider(
      {super.key, required this.data, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}

class ScaffoldWithContext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        foregroundColor: Color.fromARGB(255, 239, 236, 236),
        title: Text('ShareNa'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailsPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              backgroundColor: const Color.fromARGB(255, 18, 18, 18),
            ),
            child: Icon(Icons.account_circle, size: 50),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: bodyMethod(context),
    );
  }

  Center bodyMethod(BuildContext context) {
    final appState = AppStateManager.of(context);
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ScannerPage()), // Navigate to ScannerPage
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 18, 18, 18),
              foregroundColor: Color.fromARGB(255, 239, 236, 236),
            ),
            icon: Icon(Icons.camera_alt_rounded, size: 50),
            label: Text("Camera"),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QRCodePage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 18, 18, 18),
              foregroundColor: Color.fromARGB(255, 239, 236, 236),
            ),
            icon: Icon(Icons.qr_code_rounded, size: 50),
            label: Text("QR Code"),
          ),
        ],
      ),
    );
  }
}
