import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task? task;

  const TaskDetailScreen({Key? key, this.task}) : super(key: key);

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descController.text = widget.task!.description;
    }
  }

  void _saveTask() {
    if (_titleController.text.isEmpty) return;

    final provider = context.read<TaskProvider>();
    if (widget.task == null) {
      final newTask = Task(
        id: DateTime.now().toString(),
        title: _titleController.text,
        description: _descController.text,
      );
      provider.addTask(newTask);
    } else {
      widget.task!.title = _titleController.text;
      widget.task!.description = _descController.text;
      provider.updateTask(widget.task!);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              key: const Key('titleField'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Description'),
              key: const Key('descField'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveTask,
              key: const Key('saveButton'),
              child: const Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
