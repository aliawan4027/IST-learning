import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(const MyToDoApp());
}
class Task {
  final String title;
  bool isCompleted;
  Task({required this.title, this.isCompleted = false});
  // Convert Task object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isCompleted': isCompleted,
    };
  }
  // Convert JSON data to Task object
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }
}
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

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  late SharedPreferences _prefs;
  late List<Task> tasks = []; // Initialize tasks as an empty list
  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  // Load tasks from SharedPreferences
  Future<void> loadTasks() async {
    _prefs = await SharedPreferences.getInstance();
    final List<String>? taskList = _prefs.getStringList('tasks');
    if (taskList != null) {
      setState(() {
        tasks = taskList.map((task) => Task.fromJson(Map<String, dynamic>.from(task as Map))).toList();
      });
    }
  }

  // Save tasks to SharedPreferences
  Future<void> saveTasks() async {
    List<String> taskList = tasks.map((task) => task.toJson().toString()).toList();
    await _prefs.setStringList('tasks', taskList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks to be done"),
      ),
      body: Column(
        children: [
          // Text input and Add button
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      hintText: 'Write Task Here',
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    if (_taskController.text.isNotEmpty) {
                      setState(() {
                        tasks.add(Task(title: _taskController.text));
                        _taskController.clear();
                        saveTasks(); // Save tasks when adding a new one
                      });
                    }
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          // List of tasks
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(
                    tasks[index].title,
                    style: TextStyle(
                      decoration: tasks[index].isCompleted
                          ? TextDecoration.lineThrough // Strike through if task is completed
                          : TextDecoration.none,
                    ),
                  ),
                  value: tasks[index].isCompleted,
                  onChanged: (value) {
                    setState(() {
                      tasks[index].isCompleted = value!;
                      saveTasks(); // Save tasks when completing
                    });
                  },
                  secondary: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        tasks.removeAt(index);
                        saveTasks(); // Save tasks when deleting
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
