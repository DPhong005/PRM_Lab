import 'package:flutter/material.dart';
import 'lab5/screens/home_screen.dart';
import 'Lab4/lab4_main.dart';
import 'ReadingAppSample/ebook_app.dart';
import 'lab6/responsive_movie_screen.dart';
import 'lab7/signup_screen.dart';
import 'OnboardingExample/onboarding_app.dart';
import 'lab8/lab8_screen.dart';
import 'lab8b/screens/weather_screen.dart';
import 'lab9/screens/lab9_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Labs',
      debugShowCheckedModeBanner: false, 
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

      // Ebook Reader
      // home: const EbookApp(),

      // Onboarding Example
      // home: const OnboardingApp(),
 
      // Lab 8:
      // home: const Lab8Screen(),

      // Lab 8B (Weather Companion):
      // home: const WeatherScreen(),

      // Lab 9:
      home: const Lab9Screen(),

   
    );
  }
}
