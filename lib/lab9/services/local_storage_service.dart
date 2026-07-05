import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import '../models/task_item.dart';

class LocalStorageService {
  static const String _fileName = 'tasks.json';

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  Future<List<TaskItem>> getTasks() async {
    try {
      final file = await _localFile;

      if (!await file.exists()) {
        // If file doesn't exist in local storage, read from assets
        String jsonString = await rootBundle.loadString('assets/data/$_fileName');
        await file.writeAsString(jsonString);
      }

      String contents = await file.readAsString();
      List<dynamic> jsonList = jsonDecode(contents);
      return jsonList.map((json) => TaskItem.fromJson(json)).toList();
    } catch (e) {
      print('Error reading tasks: $e');
      return [];
    }
  }

  Future<void> saveTasks(List<TaskItem> tasks) async {
    try {
      final file = await _localFile;
      List<Map<String, dynamic>> jsonList = tasks.map((task) => task.toJson()).toList();
      String jsonString = jsonEncode(jsonList);
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Error saving tasks: $e');
    }
  }
}
