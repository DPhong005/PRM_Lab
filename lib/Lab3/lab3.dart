// ignore_for_file: avoid_print
import 'dart:async';

// ==========================================
// Exercise 1 - Product Model & Repository
// ==========================================
class Product {
  final int id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});

  @override
  String toString() => 'Product(id: $id, name: $name, price: \$$price)';
}

class ProductRepository {
  final _controller = StreamController<Product>.broadcast();

  Future<List<Product>> getAll() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      Product(id: 1, name: 'Laptop', price: 999.99),
      Product(id: 2, name: 'Phone', price: 499.99),
    ];
  }

  Stream<Product> liveAdded() => _controller.stream;

  void addProduct(Product product) {
    _controller.add(product);
  }

  void dispose() {
    _controller.close();
  }
}

Future<void> exercise1() async {
  final repo = ProductRepository();

  print('Fetching all products...');
  final allProducts = await repo.getAll();
  for (var p in allProducts) {
    print(p);
  }

  print('Listening to live added products...');
  final subscription = repo.liveAdded().listen((p) {
    print('New product added live: $p');
  });

  repo.addProduct(Product(id: 3, name: 'Tablet', price: 299.99));
  repo.addProduct(Product(id: 4, name: 'Monitor', price: 199.99));

  await Future.delayed(Duration(milliseconds: 100));
  await subscription.cancel();
  repo.dispose();
}

// ==========================================
// Exercise 2 - User Repository with JSON
// ==========================================
class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
    );
  }

  @override
  String toString() => 'User(name: $name, email: $email)';
}

class UserRepository {
  Future<List<User>> fetchUsers() async {
    await Future.delayed(Duration(seconds: 1));
    
    final List<Map<String, dynamic>> jsonList = [
      {'name': 'Alice Smith', 'email': 'alice@example.com'},
      {'name': 'Bob Jones', 'email': 'bob@example.com'}
    ];

    return jsonList.map((json) => User.fromJson(json)).toList();
  }
}

Future<void> exercise2() async {
  final repo = UserRepository();
  
  print('Fetching users from JSON...');
  final users = await repo.fetchUsers();
  
  for (var user in users) {
    print(user);
  }
}

// ==========================================
// Exercise 3 - Async + Microtask Debugging
// ==========================================
void exercise3() {
  print('Start Main Execution (Sync)');

  Future(() => print('Event Queue 1: Future executed'));
  Future(() => print('Event Queue 2: Future executed'));

  scheduleMicrotask(() => print('Microtask 1 executed'));
  Future.microtask(() => print('Microtask 2 executed'));

  print('End Main Execution (Sync)');
}

// ==========================================
// Exercise 4 - Stream Transformation
// ==========================================
Future<void> exercise4() async {
  final numberStream = Stream.fromIterable([1, 2, 3, 4, 5]);

  print('Original numbers: 1, 2, 3, 4, 5');
  print('Applying map (square) and where (even)...');

  await numberStream
      .map((number) => number * number)
      .where((square) => square % 2 == 0)
      .forEach((result) => print('Result: $result'));
}

// ==========================================
// Exercise 5 - Factory Constructors & Cache
// ==========================================
class Settings {
  static Settings? _instance;

  Settings._internal() {
    print('Settings initialized');
  }

  factory Settings() {
    _instance ??= Settings._internal();
    return _instance!;
  }
}

void exercise5() {
  print('Requesting first settings instance...');
  final s1 = Settings();
  
  print('Requesting second settings instance...');
  final s2 = Settings();

  final isIdentical = identical(s1, s2);
  print('Are both instances identical? $isIdentical');
}

// ==========================================
// Main function
// ==========================================
Future<void> main() async {
  print('--- Exercise 1 ---');
  await exercise1();

  print('\n--- Exercise 2 ---');
  await exercise2();

  print('\n--- Exercise 3 ---');
  exercise3();
  
  // Wait to allow Event Loop items from Exercise 3 to finish
  await Future.delayed(Duration(milliseconds: 100));

  print('\n--- Exercise 4 ---');
  await exercise4();

  print('\n--- Exercise 5 ---');
  exercise5();
}
