import 'package:flutter/material.dart';
import 'mock_login_screen.dart';

class MockHomeScreen extends StatelessWidget {
  const MockHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home (Lab 10.1)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MockLoginScreen()),
              );
            },
          )
        ],
      ),
      body: const Center(
        child: Text(
          'Welcome to Mock Home Screen!\nYou have successfully logged in.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
