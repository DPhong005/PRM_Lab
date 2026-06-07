// Tính trừu tượng (Abstraction): Sử dụng abstract class
abstract class Animal {
  // Tính đóng gói (Encapsulation): Sử dụng dấu _ để làm private variable
  String _name;
  int _age;

  // Constructor
  Animal(this._name, this._age);

  // Getters
  String get name => _name;
  int get age => _age;

  // Setters
  set name(String newName) {
    if (newName.isNotEmpty) {
      _name = newName;
    }
  }

  set age(int newAge) {
    if (newAge >= 0) {
      _age = newAge;
    }
  }

  // Abstract method (Phương thức trừu tượng, các lớp con phải implement)
  void makeSound();

  // Regular method
  void eat() {
    print('$_name đang ăn.');
  }
}

// Tính kế thừa (Inheritance): Dog kế thừa từ Animal
class Dog extends Animal {
  String breed;

  // Gọi constructor của lớp cha (super)
  Dog(String name, int age, this.breed) : super(name, age);

  // Tính đa hình (Polymorphism): Ghi đè (override) phương thức của lớp cha
  @override
  void makeSound() {
    print('$name (Giống: $breed) kêu: Gâu gâu!');
  }

  // Phương thức riêng của lớp Dog
  void fetch() {
    print('$name đang đi nhặt bóng.');
  }
}

// Tính kế thừa (Inheritance): Cat kế thừa từ Animal
class Cat extends Animal {
  Cat(String name, int age) : super(name, age);

  // Tính đa hình (Polymorphism): Ghi đè (override) phương thức của lớp cha
  @override
  void makeSound() {
    print('$name kêu: Meo meo!');
  }
}

void main() {
  // Tạo đối tượng (Objects)
  Dog myDog = Dog('Lulu', 3, 'Golden Retriever');
  Cat myCat = Cat('Mimi', 2);

  // Gọi các phương thức
  print('--- Thông tin về Chó ---');
  myDog.makeSound(); // Thể hiện tính đa hình
  myDog.eat();       // Kế thừa từ Animal
  myDog.fetch();     // Phương thức riêng của Dog

  print('\n--- Thông tin về Mèo ---');
  myCat.makeSound(); // Thể hiện tính đa hình
  myCat.eat();       // Kế thừa từ Animal

  // Sử dụng tính đóng gói (Getters và Setters)
  print('\n--- Đổi tên cho chó ---');
  myDog.name = 'Milu'; // Gọi setter
  print('Tên mới của chó là: ${myDog.name}'); // Gọi getter
}
