import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:prm_lab/lab11/app.dart';
import 'package:prm_lab/lab11/repositories/task_repository.dart';
import 'package:prm_lab/lab11/screens/task_list_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Taskly End-to-End Test', () {
    testWidgets('Create, edit, and delete a task', (WidgetTester tester) async {
      // 1. Khởi động ứng dụng
      await tester.pumpWidget(const TasklyApp());
      await tester.pumpAndSettle();

      // Kiểm tra trạng thái trống ban đầu
      expect(find.text('No tasks yet. Add one!'), findsOneWidget);

      // 2. Thêm Task mới
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const Key('titleField')), 'Integration Task');
      await tester.enterText(find.byKey(const Key('descField')), 'Test Description');
      await tester.tap(find.byKey(const Key('saveButton')));
      await tester.pumpAndSettle();

      // Kiểm tra Task đã được hiển thị trên màn hình List
      expect(find.text('Integration Task'), findsOneWidget);

      // 3. Đánh dấu hoàn thành Task
      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      
      // 4. Sửa Task
      await tester.tap(find.text('Integration Task'));
      await tester.pumpAndSettle();
      
      await tester.enterText(find.byKey(const Key('titleField')), 'Updated Integration Task');
      await tester.tap(find.byKey(const Key('saveButton')));
      await tester.pumpAndSettle();
      
      // Kiểm tra Task đã cập nhật
      expect(find.text('Updated Integration Task'), findsOneWidget);

      // 5. Xóa Task
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();
      
      // Kiểm tra trạng thái trống
      expect(find.text('No tasks yet. Add one!'), findsOneWidget);
    });
  });
}
