import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'unified_splash_screen.dart';

class UnifiedHomeScreen extends StatefulWidget {
  const UnifiedHomeScreen({super.key});

  @override
  State<UnifiedHomeScreen> createState() => _UnifiedHomeScreenState();
}

class _UnifiedHomeScreenState extends State<UnifiedHomeScreen> {
  String _userInfo = 'Đang tải...';
  User? _firebaseUser;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _firebaseUser = user;
        _userInfo = 'Đăng nhập qua Google';
      });
    } else {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token != null) {
        setState(() {
          _userInfo = 'Đăng nhập bằng tài khoản (Token: ${token.substring(0, 10)}...)';
        });
      }
    }
  }

  Future<void> _logout() async {
    try {
      // Xóa token
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');

      // Đăng xuất Firebase (nếu có lỗi do chưa khởi tạo Firebase thì bỏ qua)
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      debugPrint("Lỗi đăng xuất: $e");
    }

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UnifiedSplashScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_firebaseUser != null) ...[
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(_firebaseUser!.photoURL ?? ''),
                child: _firebaseUser!.photoURL == null 
                    ? const Icon(Icons.person, size: 50) 
                    : null,
              ),
              const SizedBox(height: 16),
              Text(
                'Xin chào, ${_firebaseUser!.displayName}', 
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('${_firebaseUser!.email}', style: const TextStyle(fontSize: 16, color: Colors.grey)),
            ] else ...[
              const Icon(Icons.verified_user, size: 80, color: Colors.green),
              const SizedBox(height: 16),
              const Text('Xin chào!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(_userInfo, style: const TextStyle(fontSize: 16, color: Colors.grey)),
            ],
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout),
              label: const Text('Đăng xuất'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
