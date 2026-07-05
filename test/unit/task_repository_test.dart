import 'package:flutter_test/flutter_test.dart';
import 'package:prm_lab/lab11/models/task.dart';
import 'package:prm_lab/lab11/repositories/task_repository.dart';

void main() {
  group('TaskRepository Tests', () {
    late TaskRepository repository;

    setUp(() {
      repository = TaskRepository();
    });

    test('Initial tasks list should be empty', () {
      expect(repository.getTasks(), isEmpty);
    });

    test('addTask should add a task to the list', () {
      final task = Task(id: '1', title: 'Task 1');
      repository.addTask(task);
      
      expect(repository.getTasks().length, 1);
      expect(repository.getTasks().first.title, 'Task 1');
    });

    test('updateTask should modify existing task', () {
      final task = Task(id: '1', title: 'Task 1');
      repository.addTask(task);
      
      task.title = 'Updated Task 1';
      task.toggleCompletion();
      repository.updateTask(task);
      
      final updatedTask = repository.getTasks().first;
      expect(updatedTask.title, 'Updated Task 1');
      expect(updatedTask.isCompleted, true);
    });

    test('deleteTask should remove task by id', () {
      final task1 = Task(id: '1', title: 'Task 1');
      final task2 = Task(id: '2', title: 'Task 2');
      repository.addTask(task1);
      repository.addTask(task2);
      
      expect(repository.getTasks().length, 2);
      
      repository.deleteTask('1');
      
      expect(repository.getTasks().length, 1);
      expect(repository.getTasks().first.id, '2');
    });
  });
}
