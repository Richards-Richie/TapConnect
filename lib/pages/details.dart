import 'package:flutter/material.dart';
import 'package:simple_app/main.dart';
//import 'main.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access the app state and safely set default values
    final appState = AppStateManager.of(context);
    _nameController.text = appState.name ?? '';
    _numberController.text = appState.phoneNumber ?? '';
    _emailController.text = appState.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateManager.of(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 18, 18),
      appBar: AppBar(
        title: Text('Details'),
        backgroundColor: Color.fromARGB(255, 18, 18, 18),
        foregroundColor: const Color.fromARGB(255, 232, 230, 230),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              style: TextStyle(color: const Color.fromARGB(255, 232, 230, 230)),
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle:
                    TextStyle(color: const Color.fromARGB(255, 234, 232, 232)),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.phone,
              style: TextStyle(color: Color.fromARGB(255, 239, 236, 236)),
              decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle:
                    TextStyle(color: Color.fromARGB(255, 239, 236, 236)),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Color.fromARGB(255, 239, 236, 236)),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle:
                    TextStyle(color: Color.fromARGB(255, 239, 236, 236)),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Color.fromARGB(255, 239, 236, 236),
                ),
                onPressed: () {
                  // Save the updated values in shared state
                  appState.updateDetails(
                    _nameController.text,
                    _numberController.text,
                    _emailController.text,
                  );
                  Navigator.pop(context); // Go back to the main page
                },
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
