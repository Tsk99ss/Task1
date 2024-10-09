import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';
import '../widgets/task_tile.dart';
import 'add_task_screen.dart';
import '../constants.dart'; // Import the constants file

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];
  final TaskService taskService = TaskService();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  // Load tasks from SharedPreferences
  loadTasks() async {
    tasks = await taskService.loadTasks();
    setState(() {}); // Refresh UI with loaded tasks
  }

  // Add or update a task
  void _addTask(String title, {bool isUpdate = false, Task? task}) {
    setState(() {
      if (isUpdate && task != null) {
        task.title = title; // Update the existing task
      } else {
        tasks.add(Task(title: title)); // Add a new task
      }
    });
    taskService.saveTasks(tasks); // Save updated task list
  }

  // Toggle task completion
  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].completed = !tasks[index].completed;
    });
    taskService.saveTasks(tasks); // Save updated task list
  }

  // Delete a task
  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    taskService.saveTasks(tasks); // Save updated task list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        centerTitle: true,
        title: const Text(
          Constants.appTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
      body: Container(
        color: Constants.backgroundColor,
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            Expanded(
              child: tasks.isEmpty
                  ? const Center(
                      child: Text(
                        'No data available',
                        style: TextStyle(
                          fontSize: Constants.bodyFontSize,
                          color: Constants.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TaskTile(
                              task: tasks[index],
                              onToggle: () => _toggleTaskCompletion(index),
                              onDelete: () => _deleteTask(index),
                              onEdit: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddTaskScreen(
                                      onAddTask: (title,
                                          {isUpdate = false, task}) {
                                        _addTask(title,
                                            isUpdate: true, task: tasks[index]);
                                      },
                                      task: tasks[
                                          index], // Pass the selected task for editing
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(onAddTask: _addTask),
            ),
          );
        },
        backgroundColor: Constants.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
