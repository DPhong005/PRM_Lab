import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auto_login_screen.dart';

class AutoHomeScreen extends StatefulWidget {
  const AutoHomeScreen({super.key});

  @override
  State<AutoHomeScreen> createState() => _AutoHomeScreenState();
}

class _AutoHomeScreenState extends State<AutoHomeScreen> {
  String _token = '';

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('auth_token') ?? 'No Token Found';
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token'); // Clear session token
    
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AutoLoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home (Lab 10.3)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.verified_user, color: Colors.blue, size: 80),
            const SizedBox(height: 16),
            const Text('Welcome back!', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            const Text('Session Token (Loaded from Storage):', style: TextStyle(fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _token, 
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 10)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
