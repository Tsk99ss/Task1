import 'package:flutter/material.dart';

class TaskInput extends StatefulWidget {
  final Function(String) onSubmit;

  const TaskInput({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _TaskInputState createState() => _TaskInputState();
}

class _TaskInputState extends State<TaskInput> {
  final TextEditingController controller = TextEditingController();

  void submit() {
    String taskTitle = controller.text;
    if (taskTitle.isNotEmpty) {
      widget.onSubmit(taskTitle);
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Enter a new task',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => submit(),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: submit,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
