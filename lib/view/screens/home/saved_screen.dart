import 'package:flutter/material.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            icon: const Icon(Icons.login),
          ),
        ],
      ),
      body: Text("Saved Screen"),
    );
  }
}
