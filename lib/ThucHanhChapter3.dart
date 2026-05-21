// =============================
// 1. ABSTRACT CLASS
// =============================
import 'dart:async';
abstract class Shape {
  double calculateArea();
}

class Rectangle extends Shape {
  final double width;
  final double height;

  Rectangle(this.width, this.height);

  @override
  double calculateArea() => width * height;
}

void abstractDemo() {
  Rectangle r = Rectangle(5, 10);
  print("Rectangle Area = ${r.calculateArea()}");
}

// =============================
// 2. IMPLEMENTS
// =============================

class Machine {
  void start() => print("Machine starting");
}

class Robot implements Machine {
  @override
  void start() => print("Robot booting up");
}

void implementsDemo() {
  Robot r = Robot();
  r.start();
}

// =============================
// 3. MIXIN
// =============================

mixin Tracker {
  void track(String event) {
    print("[TRACKER] Event: $event");
  }
}

class PaymentService with Tracker {
  void processPayment() {
    track("Payment processed");
  }
}

void mixinDemo() {
  PaymentService().processPayment();
}

// =============================
// 4. MIXIN CONSTRAINT
// =============================

class Device {
  String id;

  Device(this.id);
}

mixin CanConnect on Device {
  void connect() {
    print("Device $id connected to network!");
  }
}

class SmartPhone extends Device with CanConnect {
  SmartPhone() : super("IPHONE-15");
}

void mixinConstraintDemo() {
  SmartPhone().connect();
}

// =============================
// 5. FACTORY CONSTRUCTOR
// =============================

class Employee {
  final String fullName;

  Employee._(this.fullName);

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee._(json['fullName']);
  }
}

void factoryDemo() {
  var emp = Employee.fromJson({"fullName": "Nguyen Van A"});
  print("Employee Name: ${emp.fullName}");
}

// =============================
// 6. GENERIC CLASS
// =============================

class Container<T> {
  T item;

  Container(this.item);

  void display() {
    print("Item inside container: $item");
  }
}

void genericDemo() {
  Container<double>(99.9).display();
  Container<String>("Dart is cool").display();
}

// =============================
// 7. GENERIC CONSTRAINT
// =============================

abstract class Vehicle {
  String engineSound();
}

class Car extends Vehicle {
  @override
  String engineSound() => "Vroom Vroom";
}

class Garage<T extends Vehicle> {
  T vehicle;

  Garage(this.vehicle);

  void revEngine() {
    print(vehicle.engineSound());
  }
}

void genericConstraintDemo() {
  Garage<Car>(Car()).revEngine();
}

// =============================
// 8. COLLECTION IF / FOR / SPREAD
// =============================

void collectionDemo() {
  var initialSet = [10, 20, 30];

  var combinedList = [
    ...initialSet,
    if (true) 50,
    for (var val in initialSet) val + 5
  ];

  print(combinedList);
}

// =============================
// 9. CUSTOM EXCEPTION
// =============================

class AuthException implements Exception {
  final String errorMsg;

  AuthException(this.errorMsg);

  @override
  String toString() => "AuthException: $errorMsg";
}

void authenticate(String pinCode) {
  if (pinCode != "0000") {
    throw AuthException("Invalid PIN code!");
  }
}

void exceptionDemo() {
  try {
    authenticate("1234");
  } catch (err) {
    print(err);
  }
}

// =============================
// 10. EVENT LOOP & MICROTASK
// =============================

void eventLoopDemo() {
  print("Start");

  Future.microtask(() => print("Microtask executed"));

  Future(() => print("Future executed"));

  print("End");
}

// =============================
// 11. FUTURE CHAINING
// =============================

void futureChainDemo() {
  Future(() => 10)
      .then((val) => val * 2)
      .then((val) => print("Chained Future Result: $val"));
}

// =============================
// 12. STREAM + ASYNC* + YIELD
// =============================

Stream<String> generateWords() async* {
  List<String> words = ["Dart", "Flutter", "Firebase"];
  for (String word in words) {
    yield word;
  }
}

Future<void> streamDemo() async {
  await for (var w in generateWords()) {
    print("Word: $w");
  }
}

// =============================
// 13. STREAM CONTROLLER BROADCAST
// =============================

void broadcastDemo() {
  var controller = StreamController<String>.broadcast();

  controller.stream.listen((val) => print("Subscriber 1 received: $val"));
  controller.stream.listen((val) => print("Subscriber 2 received: $val"));

  controller.add("Message A");
  controller.add("Message B");
}

// =============================
// 14. REPOSITORY PATTERN (FUTURE)
// =============================

class UserRepository {
  Future<String> fetchUsername() async {
    await Future.delayed(Duration(milliseconds: 200));
    return "JohnDoe99";
  }
}

Future<void> repoFutureDemo() async {
  UserRepository repo = UserRepository();

  print("Username: ${await repo.fetchUsername()}");
}

// =============================
// 15. REPOSITORY PATTERN (STREAM)
// =============================

Stream<int> countdown() async* {
  for (int i = 3; i > 0; i--) {
    await Future.delayed(Duration(milliseconds: 200));
    yield i;
  }
}

Future<void> repoStreamDemo() async {
  await for (var count in countdown()) {
    print("Countdown: $count");
  }
}

// =============================
// 16. FINAL PRACTICE TASK
// =============================

class Book {
  final int id;
  final String title;

  Book(this.id, this.title);

  @override
  String toString() {
    return "Book(id: $id, title: '$title')";
  }
}

class BookRepository {
  Future<List<Book>> fetchBooks() async {
    await Future.delayed(Duration(seconds: 1));

    return [
      Book(101, "Dart Programming"),
      Book(102, "Flutter in Action"),
      Book(103, "Clean Architecture"),
    ];
  }

  Stream<Book> streamBooks() async* {
    List<Book> books = [
      Book(101, "Dart Programming"),
      Book(102, "Flutter in Action"),
      Book(103, "Clean Architecture"),
    ];

    for (var book in books) {
      await Future.delayed(Duration(seconds: 1));
      yield book;
    }
  }
}

Future<void> practiceTaskDemo() async {
  BookRepository repo = BookRepository();

  print("=== FUTURE BOOKS ===");

  List<Book> books = await repo.fetchBooks();

  for (var b in books) {
    print(b);
  }

  print("=== STREAM BOOKS ===");

  await for (var b in repo.streamBooks()) {
    print(b);
  }
}

// =============================
// MAIN
// =============================

Future<void> main() async {
  abstractDemo();
  implementsDemo();
  mixinDemo();
  mixinConstraintDemo();
  factoryDemo();
  genericDemo();
  genericConstraintDemo();
  collectionDemo();
  exceptionDemo();
  eventLoopDemo();
  futureChainDemo();
  await streamDemo();
  broadcastDemo();
  await repoFutureDemo();
  await repoStreamDemo();
  await practiceTaskDemo();
}