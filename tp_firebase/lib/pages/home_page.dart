import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_firebase/providers/auth_provider.dart';
import 'package:tp_firebase/services/firestore_service.dart';
import 'package:tp_firebase/widgets/task_tile.dart';
import 'package:tp_firebase/widgets/add_task_dialog.dart';
import 'package:tp_firebase/widgets/add_task_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _service = FirestoreService();

  // Mise à jour de la signature pour intercepter la catégorie et la date d'échéance
  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AddTaskDialog(
        onAdd: (title, category, dueDate) async {
          try {
            await _service.addTask(
              title: title,
              category: category,
              dueDate: dueDate,
            );
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erreur lors de l\'ajout : $e')),
              );
            }
          }
        },
      ),
    );
  }


  void _showAddBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // مهم جداً لجعل الـ BottomSheet ترتفع مع لوحة المفاتيح
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // حواف دائرية علوية
      ),
      builder: (context) => AddTaskBottomSheet(
        onAdd: (title, category, dueDate) async {
          try {
            await _service.addTask(
              title: title,
              category: category,
              dueDate: dueDate,
            );
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erreur lors de l\'ajout : $e')),
              );
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Tâches'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Déconnexion',
            onPressed: () async {
              try {
                await context.read<AuthProvider>().logout();
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erreur de déconnexion : $e')),
                  );
                }
              }
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _service.getTasksStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Une erreur est survenue : ${snapshot.error}\n\n'
                  '💡 Si vous venez d\'ajouter des champs, vérifiez dans la console '
                  'votre terminal si Firebase demande la création d\'un index.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          final tasks = snapshot.data?.docs ?? [];

          if (tasks.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.task_alt, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Aucune tâche pour le moment',
                    style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Appuyez sur + pour ajouter une tâche',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            itemCount: tasks.length,
            itemBuilder: (context, i) {
              final taskDoc = tasks[i];
              final data = taskDoc.data() as Map<String, dynamic>;

              return TaskTile(
                taskDoc: taskDoc,
                onToggle: () {
                  _service.toggleTask(taskDoc.id, data['done'] ?? false);
                },
                onDelete: () => _service.deleteTask(taskDoc.id),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddBottomSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}
