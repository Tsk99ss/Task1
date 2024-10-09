class Task {
  String title;
  bool completed;

  Task({required this.title, this.completed = false});

  // Convert Task to JSON format for saving in SharedPreferences
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'completed': completed,
    };
  }

  // Create a Task object from JSON format
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      completed: json['completed'],
    );
  }
}
