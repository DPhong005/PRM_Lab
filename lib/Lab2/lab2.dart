// ignore_for_file: avoid_print
// Lab 2 – Dart Essentials Practice Lab
// This file contains all 5 exercises covering fundamental Dart concepts.

import 'dart:async';

// ==========================================
// Exercise 4 - Intro to OOP
// ==========================================
class Car {
  String brand;

  Car(this.brand);

  Car.unknown() : brand = 'Unknown Brand';

  void drive() {
    print('$brand is driving.');
  }
}

class ElectricCar extends Car {
  double batteryLevel;

  ElectricCar(super.brand, this.batteryLevel);

  @override
  void drive() {
    print('$brand (Electric) is driving silently with $batteryLevel% battery.');
  }
}

// ==========================================
// Main function executing all exercises
// ==========================================
void main() async {
  print('--- Exercise 1: Basic Syntax & Data Types ---');
  exercise1();

  print('\n--- Exercise 2: Collections & Operators ---');
  exercise2();

  print('\n--- Exercise 3: Control Flow & Functions ---');
  exercise3();

  print('\n--- Exercise 4: Intro OOP ---');
  exercise4();

  print('\n--- Exercise 5: Async & Null Safety ---');
  await exercise5();
}

// ==========================================
// Exercise 1 - Basic Syntax & Data Types
// ==========================================
void exercise1() {
  int age = 20;
  double height = 1.75;
  String name = 'Alice';
  bool isStudent = true;

  print('Name: $name');
  print('Age: $age');
  print('Height: $height meters');
  print('Is Student: $isStudent');
  print('Next year, $name will be ${age + 1} years old.');
}

// ==========================================
// Exercise 2 - Collections & Operators
// ==========================================
void exercise2() {
  List<int> numbers = [10, 20, 30, 40];
  
  int sum = numbers[0] + numbers[1];
  int diff = numbers[3] - numbers[2];
  bool isEqual = (sum == diff);
  bool logicalCheck = (sum > 0 && diff > 0);
  String result = logicalCheck ? 'Both positive' : 'Not both positive';

  print('Sum: $sum, Diff: $diff, isEqual: $isEqual, Result: $result');

  Set<String> uniqueFruits = {'Apple', 'Banana', 'Orange'};
  Map<String, int> fruitPrices = {'Apple': 2, 'Banana': 1, 'Orange': 3};

  numbers.add(50);
  numbers.remove(10);
  print('List after modifications: $numbers');

  uniqueFruits.add('Apple');
  uniqueFruits.remove('Banana');
  print('Set after modifications: $uniqueFruits');

  print('Price of Apple: \$${fruitPrices['Apple']}');
}

// ==========================================
// Exercise 3 - Control Flow & Functions
// ==========================================
void exercise3() {
  int score = 85;
  if (score >= 90) {
    print('Grade: A');
  } else if (score >= 80) {
    print('Grade: B');
  } else {
    print('Grade: C or lower');
  }

  int day = 3;
  switch (day) {
    case 1:
      print('Monday');
      break;
    case 2:
      print('Tuesday');
      break;
    case 3:
      print('Wednesday');
      break;
    default:
      print('Other day');
  }

  List<String> colors = ['Red', 'Green', 'Blue'];
  
  print('Using for loop:');
  for (int i = 0; i < colors.length; i++) {
    print(colors[i]);
  }

  print('Using for-in loop:');
  for (String color in colors) {
    print(color);
  }

  print('Using forEach():');
  colors.forEach(print);

  print('Square of 4 (normal): ${squareNormal(4)}');
  print('Square of 4 (arrow): ${squareArrow(4)}');
}

int squareNormal(int num) {
  return num * num;
}

int squareArrow(int num) => num * num;

// ==========================================
// Exercise 4 - Intro to OOP (Usage)
// ==========================================
void exercise4() {
  Car regularCar = Car('Toyota');
  regularCar.drive();

  Car unknownCar = Car.unknown();
  unknownCar.drive();

  ElectricCar tesla = ElectricCar('Tesla', 85.5);
  tesla.drive();
}

// ==========================================
// Exercise 5 - Async, Future, Null Safety & Streams
// ==========================================
Future<void> exercise5() async {
  print('Starting async task...');
  
  await Future.delayed(Duration(seconds: 2));
  print('Data loaded successfully after 2 seconds.');

  String? nullableString;
  
  int length = nullableString?.length ?? 0; 
  print('Length of nullableString: $length');

  nullableString = 'Dart is awesome';
  print('Length when non-null: ${nullableString.length}');

  print('Listening to stream...');
  Stream<int> numberStream = Stream.periodic(Duration(milliseconds: 500), (x) => x + 1).take(3);
  
  await for (int number in numberStream) {
    print('Received from stream: $number');
  }
}
