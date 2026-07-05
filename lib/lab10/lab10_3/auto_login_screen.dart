import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'auto_home_screen.dart';

class AutoLoginScreen extends StatefulWidget {
  const AutoLoginScreen({super.key});

  @override
  State<AutoLoginScreen> createState() => _AutoLoginScreenState();
}

class _AutoLoginScreenState extends State<AutoLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = 'emilys'; // Pre-filled for quick testing
  String _password = 'emilyspass';
  bool _isLoading = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => _isLoading = true);

      try {
        final response = await http.post(
          Uri.parse('https://dummyjson.com/auth/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'username': _username, 'password': _password}),
        );

        setState(() => _isLoading = false);

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final token = data['token'];

          // Save token to SharedPreferences for persistence
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', token);
          
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AutoHomeScreen()),
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login Failed'), backgroundColor: Colors.red),
            );
          }
        }
      } catch (e) {
        setState(() => _isLoading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Network error: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 10.3 - Auto Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  initialValue: _username,
                  decoration: const InputDecoration(labelText: 'Username'),
                  onSaved: (value) => _username = value!.trim(),
                ),
                TextFormField(
                  initialValue: _password,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onSaved: (value) => _password = value!,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: _login, 
                          child: const Text('Login & Save Session'),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
