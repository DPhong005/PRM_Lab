class Book {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final double progress;
  final String category;
  final String description;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.progress,
    required this.category,
    required this.description,
  });
}

class Chapter {
  final String title;
  final List<String> pages;

  Chapter({required this.title, required this.pages});
}

class Bookmark {
  final String id;
  final String bookId;
  final String chapterTitle;
  final int pageIndex;
  final String snippet;
  final DateTime createdAt;

  Bookmark({
    required this.id,
    required this.bookId,
    required this.chapterTitle,
    required this.pageIndex,
    required this.snippet,
    required this.createdAt,
  });
}

// Mock Data
final List<Book> mockBooks = [
  Book(
    id: '1',
    title: 'The Flutter Way',
    author: 'Dash Dart',
    coverUrl: 'https://picsum.photos/seed/flutter/200/300',
    progress: 0.45,
    category: 'Technology',
    description: 'A comprehensive guide to building beautiful native apps with Flutter. Explore the core concepts and advanced features.',
  ),
  Book(
    id: '2',
    title: 'Design Systems',
    author: 'UI/UX Master',
    coverUrl: 'https://picsum.photos/seed/design/200/300',
    progress: 0.12,
    category: 'Design',
    description: 'Mastering Material 3 and modern design trends for mobile applications. Learn how to create stunning user interfaces.',
  ),
  Book(
    id: '3',
    title: 'Clean Architecture',
    author: 'Robert C. Martin',
    coverUrl: 'https://picsum.photos/seed/clean/200/300',
    progress: 0.89,
    category: 'Engineering',
    description: 'A Craftsman\'s Guide to Software Structure and Design. The rules of clean architecture and how to apply them.',
  ),
  Book(
    id: '4',
    title: 'Effective Dart',
    author: 'Dart Team',
    coverUrl: 'https://picsum.photos/seed/dart/200/300',
    progress: 0.0,
    category: 'Programming',
    description: 'Official guidelines for writing clean and effective Dart code. Essential for any serious Flutter developer.',
  ),
];

final List<Chapter> mockChapters = [
  Chapter(
    title: 'Chapter 1: Introduction to Flutter',
    pages: [
      'Flutter is Google’s UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.\n\nFlutter works with existing code, is used by developers and organizations around the world, and is free and open source.',
      'Widgets are the basic building blocks of a Flutter app’s user interface. Each widget is an immutable declaration of part of the user interface. Unlike other frameworks that separate views, view controllers, layouts, and other properties, Flutter has a consistent, unified object model: the widget.',
      'A widget can define structural elements (like a button or menu), stylistic elements (like a font or color scheme), layout aspects (like padding), and so on. Widgets form a hierarchy based on composition. Each widget nests inside, and inherits properties from, its parent.',
    ]
  ),
  Chapter(
    title: 'Chapter 2: Building Layouts',
    pages: [
      'In Flutter, building a layout means composing widgets to create a more complex widget. For example, you can pack multiple widgets into a Row or Column, wrap a widget in a Padding or Center, or overlay widgets using a Stack.',
      'The core of Flutter’s layout mechanism is widgets. Almost everything is a widget - even layout models are widgets. The images, icons, and text that you see in a Flutter app are all widgets.',
      'Things that you don’t see are also widgets, such as the rows, columns, and grids that arrange, constrain, and align the visible widgets. By composing these simple widgets, you can build complex layouts.',
    ]
  ),
  Chapter(
    title: 'Chapter 3: State Management',
    pages: [
      'State management is a complex topic in Flutter. If you are building a large app, you will need a robust way to manage state across multiple screens.',
      'There are many state management solutions available for Flutter, including Provider, Riverpod, BLoC, Redux, and MobX. Each has its own strengths and weaknesses, so it’s important to choose the right one for your app.',
      'In this chapter, we will explore the different state management options and how to implement them in your app. We will start with simple approaches and move on to more advanced architectures.',
    ]
  )
];

// Global bookmarks store (simple for mockup)
List<Bookmark> globalBookmarks = [
  Bookmark(
    id: 'b1',
    bookId: '1',
    chapterTitle: 'Chapter 1: Introduction to Flutter',
    pageIndex: 1,
    snippet: 'Widgets are the basic building blocks of a Flutter app’s user interface...',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Bookmark(
    id: 'b2',
    bookId: '1',
    chapterTitle: 'Chapter 2: Building Layouts',
    pageIndex: 0,
    snippet: 'In Flutter, building a layout means composing widgets to create a more complex widget...',
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
  )
];
