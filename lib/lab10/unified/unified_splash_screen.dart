import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'unified_login_screen.dart';
import 'unified_home_screen.dart';

class UnifiedSplashScreen extends StatefulWidget {
  const UnifiedSplashScreen({super.key});

  @override
  State<UnifiedSplashScreen> createState() => _UnifiedSplashScreenState();
}

class _UnifiedSplashScreenState extends State<UnifiedSplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Đợi 2 giây để hiển thị splash screen
    await Future.delayed(const Duration(seconds: 2));
    
    String? token;
    User? user;
    
    try {
      // Kiểm tra token lưu ở SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('auth_token');

      // Kiểm tra user đã đăng nhập Firebase (Google Sign-In) chưa
      user = FirebaseAuth.instance.currentUser;
    } catch (e) {
      debugPrint("Lỗi khi kiểm tra trạng thái đăng nhập: $e");
      // Nếu có lỗi (ví dụ Firebase chưa khởi tạo thành công), coi như chưa đăng nhập
    }

    if (mounted) {
      if ((token != null && token.isNotEmpty) || user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UnifiedHomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UnifiedLoginScreen()),
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
            Icon(Icons.shield, size: 80, color: Colors.blueAccent),
            SizedBox(height: 16),
            Text('Đang kiểm tra phiên đăng nhập...', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
