import 'package:flutter/material.dart';
import '../models/task_item.dart';
import '../services/local_storage_service.dart';

class Lab9Screen extends StatefulWidget {
  const Lab9Screen({super.key});

  @override
  State<Lab9Screen> createState() => _Lab9ScreenState();
}

class _Lab9ScreenState extends State<Lab9Screen> {
  final LocalStorageService _storageService = LocalStorageService();
  List<TaskItem> _tasks = [];
  List<TaskItem> _filteredTasks = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await _storageService.getTasks();
    setState(() {
      _tasks = tasks;
      _filteredTasks = tasks;
      _isLoading = false;
    });
  }

  Future<void> _saveTasks() async {
    await _storageService.saveTasks(_tasks);
  }

  void _addTask(String title) {
    if (title.trim().isEmpty) return;
    
    final newTask = TaskItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
    );
    
    setState(() {
      _tasks.add(newTask);
      _filterTasks(_searchQuery);
    });
    _saveTasks();
  }

  void _toggleTask(TaskItem task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
    _saveTasks();
  }

  void _deleteTask(TaskItem task) {
    setState(() {
      _tasks.removeWhere((t) => t.id == task.id);
      _filterTasks(_searchQuery);
    });
    _saveTasks();
  }

  void _editTask(TaskItem task, String newTitle) {
    if (newTitle.trim().isEmpty) return;
    
    setState(() {
      task.title = newTitle.trim();
    });
    _saveTasks();
  }

  void _filterTasks(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredTasks = _tasks;
      } else {
        _filteredTasks = _tasks
            .where((task) => task.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _showTaskDialog({TaskItem? taskToEdit}) {
    final TextEditingController controller = TextEditingController(text: taskToEdit?.title ?? '');
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(taskToEdit == null ? 'Add Task' : 'Edit Task'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Enter task title'),
            onSubmitted: (value) {
              if (taskToEdit == null) {
                _addTask(value);
              } else {
                _editTask(taskToEdit, value);
              }
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (taskToEdit == null) {
                  _addTask(controller.text);
                } else {
                  _editTask(taskToEdit, controller.text);
                }
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 9: Local JSON Tasks'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search tasks...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    onChanged: _filterTasks,
                  ),
                ),
                Expanded(
                  child: _filteredTasks.isEmpty
                      ? const Center(child: Text('No tasks found.'))
                      : ListView.builder(
                          itemCount: _filteredTasks.length,
                          itemBuilder: (context, index) {
                            final task = _filteredTasks[index];
                            return Dismissible(
                              key: Key(task.id),
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                child: const Icon(Icons.delete, color: Colors.white),
                              ),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) => _deleteTask(task),
                              child: ListTile(
                                leading: Checkbox(
                                  value: task.isCompleted,
                                  onChanged: (_) => _toggleTask(task),
                                ),
                                title: Text(
                                  task.title,
                                  style: TextStyle(
                                    decoration: task.isCompleted
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    color: task.isCompleted ? Colors.grey : null,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => _showTaskDialog(taskToEdit: task),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
