import 'package:flutter/material.dart';
import 'exercise_1.dart';
import 'exercise_2.dart';
import 'exercise_3.dart';
import 'exercise_4.dart';
import 'exercise_5.dart';

class Lab4MainScreen extends StatelessWidget {
  const Lab4MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 4 – Flutter UI Fundamentals'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildMenuCard(context, 'Exercise 1 – Core Widgets Demo', const CoreWidgetsDemo()),
          _buildMenuCard(context, 'Exercise 2 – Input Controls Demo', const InputControlsDemo()),
          _buildMenuCard(context, 'Exercise 3 – Layout Demo', LayoutDemo()),
          _buildMenuCard(context, 'Exercise 4 – App Structure & Theme', const AppStructureThemeDemo()),
          _buildMenuCard(context, 'Exercise 5 – Common UI Fixes', const CommonUIFixesDemo()),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, Widget page) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      color: Colors.grey[100],
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
      ),
    );
  }
}
