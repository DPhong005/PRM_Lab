import 'package:flutter/material.dart';
import 'lab5/screens/home_screen.dart';
import 'lab4/lab4_main.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Labs',
      debugShowCheckedModeBanner: false, // Ẩn chữ DEBUG ở góc phải
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // =========== HƯỚNG DẪN CHUYỂN ĐỔI LAB ===========
      // Cách dùng: Chỉ để MỘT dòng `home:` hoạt động, dòng còn lại hãy thêm `//` ở đầu để comment lại.
      
      // 👉 Để chạy Lab 4, hãy bỏ comment (xoá dấu //) ở dòng dưới:
      // home: const Lab4MainScreen(), 
      
      // 👉 Để chạy Lab 5, hãy bỏ comment (xoá dấu //) ở dòng dưới:
      home: const HomeScreen(),
      // ================================================
    );
  }
}
