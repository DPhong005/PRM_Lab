import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prm_lab/lab11/models/task.dart';
import 'package:prm_lab/lab11/repositories/task_repository.dart';
import 'package:prm_lab/lab11/screens/task_list_screen.dart';

void main() {
  group('TaskListScreen Widget Tests', () {
    testWidgets('Displays empty state when there are no tasks', (WidgetTester tester) async {
      final repository = TaskRepository();
      
      await tester.pumpWidget(MaterialApp(
        home: TaskListScreen(repository: repository),
      ));
      
      expect(find.text('No tasks yet. Add one!'), findsOneWidget);
    });

    testWidgets('Displays tasks when repository is not empty', (WidgetTester tester) async {
      final repository = TaskRepository();
      repository.addTask(Task(id: '1', title: 'Task 1'));
      repository.addTask(Task(id: '2', title: 'Task 2'));
      
      await tester.pumpWidget(MaterialApp(
        home: TaskListScreen(repository: repository),
      ));
      
      expect(find.text('Task 1'), findsOneWidget);
      expect(find.text('Task 2'), findsOneWidget);
    });

    testWidgets('Tapping FAB navigates to TaskDetailScreen', (WidgetTester tester) async {
      final repository = TaskRepository();
      
      await tester.pumpWidget(MaterialApp(
        home: TaskListScreen(repository: repository),
      ));
      
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      
      expect(find.text('Add Task'), findsOneWidget);
      expect(find.byKey(const Key('titleField')), findsOneWidget);
    });
  });
}
