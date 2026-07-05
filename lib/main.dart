import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'lab5/screens/home_screen.dart';
import 'Lab4/lab4_main.dart';
import 'ReadingAppSample/ebook_app.dart';
import 'lab6/responsive_movie_screen.dart';
import 'lab7/signup_screen.dart';
import 'OnboardingExample/onboarding_app.dart';
import 'lab8/lab8_screen.dart';
import 'lab8b/screens/weather_screen.dart';
import 'lab10/lab10_1/mock_login_screen.dart';
import 'lab10/lab10_2/real_login_screen.dart';
import 'lab10/lab10_3/auto_splash_screen.dart';
import 'lab10/lab10_4/google_login_screen.dart';
import 'lab10/services/notification_service.dart';
import 'lab10/unified/unified_splash_screen.dart';
// import 'lab11/screens/task_list_screen.dart';
// import 'lab11/repositories/task_repository.dart';

// Lab 12 imports
import 'lab12/providers/task_provider.dart';
import 'lab12/screens/task_list_screen.dart' as lab12;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    await NotificationService.initialize();
  } catch (e) {
    debugPrint("Firebase/Notification init error: $e");
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
      // home: const Lab9Screen(),

      // Lab 10
      // home: const UnifiedSplashScreen(),
      
      // Lab 11
      // home: TaskListScreen(repository: TaskRepository()),
      
      // Lab 12
      home: const lab12.TaskListScreen(),
    );
  }
}
