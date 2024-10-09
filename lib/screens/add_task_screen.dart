import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../constants.dart'; // Import the constants file

class AddTaskScreen extends StatefulWidget {
  final Function(String, {bool isUpdate, Task? task}) onAddTask;
  final Task? task; // Optional task for editing

  const AddTaskScreen({
    Key? key,
    required this.onAddTask,
    this.task, // Accept task parameter for editing
  }) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController controller = TextEditingController();
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      controller.text = widget.task!.title; // Pre-fill the text field if editing
    }
  }

  void submit() {
    String taskTitle = controller.text.trim(); // Trim whitespace
    if (taskTitle.isEmpty) {
      setState(() {
        errorMessage = 'Please enter a task'; // Set error message for empty input
      });
      return; // Stop execution if validation fails
    }
    setState(() {
      errorMessage = null; // Clear error message
    });
    widget.onAddTask(taskTitle, isUpdate: widget.task != null, task: widget.task);
    Navigator.pop(context); // Go back to home screen after adding/updating task
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context), // Go back to the previous screen
        ),
        title: const Text(
          'Add Task',
          style: TextStyle(
            color: Colors.white, // Set title color to white
            fontSize: 20, // Set font size to 20
          ),
        ),
        backgroundColor: Constants.primaryColor, // Use primary color
      ),
      body: Padding(
        padding: Constants.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: Constants.addTaskHint,
                hintStyle: const TextStyle(
                  color: Constants.secondaryColor, // Hint text color
                  fontSize: 14, // Reduce the font size of the hint text
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)), // Add border radius
                ),
                errorText: errorMessage, // Show error message if validation fails
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding inside the TextField
              ),
              onSubmitted: (_) => submit(),
              style: const TextStyle(fontSize: 16), // Set a smaller font size if needed
            ),
            const SizedBox(height: 16), // Space between the text field and button
            ElevatedButton(
              onPressed: submit,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Constants.primaryColor, // Text color
              ),
              child: Text(widget.task == null ? 'Add Task' : 'Update Task'), // Conditional button text
            ),
          ],
        ),
      ),
    );
  }
}
