import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auto_login_screen.dart';
import 'auto_home_screen.dart';

class AutoSplashScreen extends StatefulWidget {
  const AutoSplashScreen({super.key});

  @override
  State<AutoSplashScreen> createState() => _AutoSplashScreenState();
}

class _AutoSplashScreenState extends State<AutoSplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Artificial delay to show splash screen (2 seconds)
    await Future.delayed(const Duration(seconds: 2));
    
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (mounted) {
      if (token != null && token.isNotEmpty) {
        // Token exists, auto login to Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AutoHomeScreen()),
        );
      } else {
        // No token, go to Login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AutoLoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flash_on, size: 80, color: Colors.orange),
            SizedBox(height: 16),
            Text('Checking session...', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
