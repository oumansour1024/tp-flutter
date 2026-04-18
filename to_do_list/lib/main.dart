import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const TodoPage(),
    );
  }
}


class Task {
  final String title;
  final String description;
  bool isCompleted;
  final String priority; // 'High', 'Medium', 'Low'

  Task({
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.priority = 'Medium',
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'isCompleted': isCompleted,
    'priority': priority,
  };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    title: json['title'],
    description: json['description'],
    isCompleted: json['isCompleted'],
    priority: json['priority'] ?? 'Medium',
  );
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

 
  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(_tasks.map((t) => t.toJson()).toList());
    await prefs.setString('tasks_key', encodedData);
  }


  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedData = prefs.getString('tasks_key');
    if (savedData != null) {
      final List<dynamic> decodedData = json.decode(savedData);
      setState(() {
        _tasks = decodedData.map((item) => Task.fromJson(item)).toList();
      });
    }
  }


  void _deleteTask(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("confirmation"),
        content: const Text("etes-vous sûr de vouloir supprimer cette tâche?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Annuler")),
          TextButton(
            onPressed: () {
              setState(() => _tasks.removeAt(index));
              _saveTasks();
              Navigator.pop(ctx);
            },
            child: const Text("Supprimer", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _tasks.sort((a, b) => a.isCompleted ? 1 : -1);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des tâches", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: _tasks.isEmpty
          ? const Center(child: Text("Aucune tâche pour le moment.\n Cliquez sur + pour en ajouter!", style: TextStyle(fontSize: 16, color: Colors.grey)))
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: task.priority == 'High' ? Colors.red : (task.priority == 'Medium' ? Colors.orange : Colors.green),
                      radius: 8,
                    ),
                    title: Text(task.title, style: TextStyle(decoration: task.isCompleted ? TextDecoration.lineThrough : null)),
                    subtitle: Text("${task.description} (${task.priority})"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: task.isCompleted,
                          onChanged: (val) {
                            setState(() => task.isCompleted = val!);
                            _saveTasks();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => _deleteTask(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push<Task>(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskPage()),
          );
          if (newTask != null) {
            setState(() => _tasks.add(newTask));
            _saveTasks();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  String selectedPriority = 'Medium';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter une tâche')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Titre', border: OutlineInputBorder())),
            const SizedBox(height: 15),
            TextField(controller: descController, decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder())),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              initialValue: selectedPriority,
              items: ['High', 'Medium', 'Low'].map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
              onChanged: (val) => setState(() => selectedPriority = val!),
              decoration: const InputDecoration(labelText: 'Priorité', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  Navigator.pop(context, Task(
                    title: titleController.text,
                    description: descController.text,
                    priority: selectedPriority,
                  ));
                }
              },
              child: const Text('Enregistrer la tâche'),
            ),
          ],
        ),
      ),
    );
  }
}
