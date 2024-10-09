import 'package:flutter/material.dart';

class Constants {
  // Colors
  static const Color primaryColor = Color(0xFF6A1B9A); // Purple shade
  static const Color secondaryColor = Color(0xFF8E24AA); // Lighter purple
  static const Color backgroundColor = Color(0xFFF3E5F5); // Light purple background
  static const Color taskCompleteColor = Color(0xFFD1C4E9); // Completed task color

  // Font sizes
  static const double titleFontSize = 24.0;
  static const double bodyFontSize = 16.0;

  // Padding and Margins
  static const EdgeInsets defaultPadding = EdgeInsets.all(16.0);
  static const EdgeInsets smallPadding = EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0);

  // Strings
  static const String appTitle = 'To-Do List';
  static const String addTaskHint = 'Enter a new task';

  // Other constants
  static const int maxTaskTitleLength = 50; // Example limit for task title length
}
