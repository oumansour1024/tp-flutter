import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class AddTaskDialog {
  static Future<void> show(BuildContext context) {
    final taskController = TextEditingController();
    final service = FirestoreService();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Nouvelle tâche'),
          content: TextField(
            controller: taskController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Que devez-vous faire ?',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                final title = taskController.text.trim();
                if (title.isNotEmpty) {
                  service.addTask(title);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Veuillez saisir une tâche')),
                  );
                }
              },
              child: Text('Ajouter'),
            ),
          ],
        );
      },
    ).then((_) => taskController.dispose());
  }
}