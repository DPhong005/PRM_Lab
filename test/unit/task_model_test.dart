import 'package:flutter_test/flutter_test.dart';
import 'package:prm_lab/lab11/models/task.dart';

void main() {
  group('Task Model Tests', () {
    test('Task should be created with correct initial values', () {
      final task = Task(id: '1', title: 'Test Task');
      
      expect(task.id, '1');
      expect(task.title, 'Test Task');
      expect(task.description, '');
      expect(task.isCompleted, false);
    });

    test('toggleCompletion should change isCompleted status', () {
      final task = Task(id: '1', title: 'Test Task');
      
      expect(task.isCompleted, false);
      
      task.toggleCompletion();
      expect(task.isCompleted, true);
      
      task.toggleCompletion();
      expect(task.isCompleted, false);
    });
  });
}
