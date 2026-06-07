import 'package:flutter/material.dart';
import 'lab5/screens/home_screen.dart';
import 'lab4/lab4_main.dart'; 
import 'lab6/responsive_movie_screen.dart'; // Import Lab 6

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
      // =========== MENU CHẠY LAB ===========
      // 👉 Chạy Lab 4:
      // home: const Lab4MainScreen(), 
      
      // 👉 Chạy Lab 5:
      // home: const HomeScreen(),

      // 👉 Để chạy Lab 6, hãy bỏ comment (xoá dấu //) ở dòng dưới:
      home: const ResponsiveMovieApp(),
      // ================================================
    );
  }
}
