import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/notification_service.dart';

class GoogleLoginScreen extends StatefulWidget {
  const GoogleLoginScreen({super.key});

  @override
  State<GoogleLoginScreen> createState() => _GoogleLoginScreenState();
}

class _GoogleLoginScreenState extends State<GoogleLoginScreen> {
  User? _user;
  bool _isLoading = false;

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 1. Kích hoạt luồng đăng nhập Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      
      if (googleUser == null) {
        // Người dùng hủy (cancel) luồng đăng nhập
        setState(() => _isLoading = false);
        return;
      }

      // 2. Lấy thông tin xác thực từ request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // 3. Tạo credential cho Firebase
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Đăng nhập vào Firebase bằng credential
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      
      setState(() {
        _user = userCredential.user;
        _isLoading = false;
      });

      // 5. Nếu đăng nhập thành công -> Hiển thị Local Notification (Lab 10.5)
      if (_user != null) {
        // Gắn tên user vào nội dung thông báo
        await NotificationService.showLoginSuccessNotification(_user!.displayName ?? 'Người dùng');
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đăng nhập thành công! Đã gửi thông báo.')),
          );
        }
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        // Xử lý Try-Catch an toàn trong trường hợp thiếu file google-services.json hoặc mã SHA-1
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Lỗi đăng nhập (Chưa cấu hình Firebase):\n$e',
              maxLines: 5,
            ),
            duration: const Duration(seconds: 4),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  Future<void> _signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    setState(() {
      _user = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 10.4 & 10.5: Google Auth & Noti'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: _isLoading 
            ? const CircularProgressIndicator()
            : _user != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(_user!.photoURL ?? ''),
                        child: _user!.photoURL == null 
                            ? const Icon(Icons.person, size: 50) 
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Xin chào, ${_user!.displayName}', 
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('${_user!.email}', style: const TextStyle(fontSize: 16, color: Colors.grey)),
                      const SizedBox(height: 32),
                      ElevatedButton.icon(
                        onPressed: _signOut,
                        icon: const Icon(Icons.logout),
                        label: const Text('Đăng xuất'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.security, size: 80, color: Colors.deepPurple),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: _signInWithGoogle,
                        icon: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/2991/2991148.png',
                          height: 24,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.login),
                        ),
                        label: const Text('Đăng nhập bằng Google'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
