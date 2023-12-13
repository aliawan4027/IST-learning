import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyToDoApp());
}

- `import 'package:flutter/material.dart';`: This line imports Flutter's material library, which contains widgets, themes, and other elements for building user interfaces (UIs).
- `import 'package:shared_preferences/shared_preferences.dart';`: This line imports the `SharedPreferences` package, which allows the app to persistently store and retrieve small amounts of primitive data.

class Task {
  final String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }
}

- `class Task { ... }`: Defines a class `Task` to represent a task in the to-do list application. It contains properties such as `title` and `isCompleted`.
- `Task({required this.title, this.isCompleted = false});`: Defines a constructor for the `Task` class. It initializes the `title` and `isCompleted` properties.
- `Map<String, dynamic> toJson() { ... }`: Defines a method to convert a `Task` object into a JSON representation.
- `factory Task.fromJson(Map<String, dynamic> json) { ... }`: Defines a factory method to create a `Task` object from JSON data.

class MyToDoApp extends StatelessWidget {
  const MyToDoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const ToDoListScreen(),
    );
  }
}


- `class MyToDoApp extends StatelessWidget { ... }`: Defines a stateless widget `MyToDoApp` that represents the entire application.
- `MaterialApp(...)` inside the `build` method: Constructs a `MaterialApp`, which is the root widget of the app. It provides basic app functionalities like theming, navigation, etc., and sets `ToDoListScreen` as the home screen.

The rest of the code sets up the to-do list screen (`ToDoListScreen`) with features to add, display, and manage tasks using `SharedPreferences` for persistent storage. It includes text input for tasks, a list to display tasks, checkboxes to mark tasks as completed, and buttons to add and delete tasks.

This code is a basic implementation of a to-do list application in Flutter, demonstrating how to use widgets, manage state, and store/retrieve data using `SharedPreferences`.