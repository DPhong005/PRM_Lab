import 'package:flutter/material.dart';
import 'lab5/screens/home_screen.dart';
import 'Lab4/lab4_main.dart';
import 'ReadingAppSample/ebook_app.dart';
import 'lab6/responsive_movie_screen.dart';
import 'lab7/signup_screen.dart';

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
      
      // Lab 4:
      // home: const Lab4MainScreen(), 
      
      // Lab 5:
      // home: const HomeScreen(),

      //  Lab 6:
      // home: const ResponsiveMovieApp(),
      
      //  Lab 7:
      // home: const SignupApp(),

      // Lab 8: Ebook Reader
      home: const EbookApp(),
      // =====================================
    );
  }
}
