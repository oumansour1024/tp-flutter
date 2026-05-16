import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';

class TaskTile extends StatelessWidget {
  final QueryDocumentSnapshot taskDoc;
  final Map<String, dynamic> taskData;
  final FirestoreService service;

  const TaskTile({
    Key? key,
    required this.taskDoc,
    required this.taskData,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDone = taskData['done'] ?? false;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(
          taskData['title'] ?? '',
          style: TextStyle(
            decoration: isDone ? TextDecoration.lineThrough : null,
            color: isDone ? Colors.grey : null,
          ),
        ),
        leading: Checkbox(
          value: isDone,
          onChanged: (_) => service.toggleTask(taskDoc.id, isDone),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => _confirmDelete(context),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Supprimer la tâche'),
        content: Text('Voulez-vous vraiment supprimer cette tâche ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              service.deleteTask(taskDoc.id);
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Supprimer', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}