import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/task_model.dart';

class TaskService {
  final String _tasksKey = 'tasks';

  // Save tasks list to SharedPreferences
  Future<void> saveTasks(List<Task> tasks) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskListJson = tasks.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList(_tasksKey, taskListJson);
  }

  // Load tasks from SharedPreferences
  Future<List<Task>> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskListJson = prefs.getStringList(_tasksKey);

    if (taskListJson != null) {
      return taskListJson.map((taskJson) => Task.fromJson(jsonDecode(taskJson))).toList();
    } else {
      return [];
    }
  }
}
