import 'package:flutter/material.dart';

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 1 – Core Widgets'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Headline Text
              const Text(
                'Welcome to Flutter UI',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              
              // Icon using Material Icons
              const Icon(
                Icons.movie,
                size: 64,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              
              // Image.network
              Image.network(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 50),
              ),
              const SizedBox(height: 20),
              
              // Card containing a ListTile
              const Card(
                elevation: 2,
                child: ListTile(
                  leading: Icon(Icons.star),
                  title: Text('Movie Item'),
                  subtitle: Text('This is a sample ListTile inside a Card.'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
