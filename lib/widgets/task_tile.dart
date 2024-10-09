import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEdit; // New callback for editing

  const TaskTile({
    Key? key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit, // Accept edit callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0), // Add padding to the tile
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align children to the ends
        children: [
          Expanded(
            child: Row(
              children: [
                Checkbox(
                  value: task.completed,
                  onChanged: (bool? value) {
                    onToggle();
                  },
                ),
                Expanded(
                  child: Text(
                    task.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      decoration: task.completed ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, size: 20.0,),
                onPressed: onEdit, // Call the edit callback
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 20.0,),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
