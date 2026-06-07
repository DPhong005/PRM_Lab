import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  LayoutDemo({super.key});

  final List<Map<String, String>> movies = [
    {'title': 'Avatar', 'desc': 'Sample description'},
    {'title': 'Inception', 'desc': 'Sample description'},
    {'title': 'Interstellar', 'desc': 'Sample description'},
    {'title': 'Joker', 'desc': 'Sample description'},
    {'title': 'The Dark Knight', 'desc': 'Sample description'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3 – Layout Demo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Now Playing',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    color: Colors.grey[100],
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigo[100],
                        child: Text(movies[index]['title']![0]),
                      ),
                      title: Text(movies[index]['title']!),
                      subtitle: Text(movies[index]['desc']!),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
