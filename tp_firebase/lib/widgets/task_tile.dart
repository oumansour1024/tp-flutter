import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Importation de la boîte de dialogue pour réutiliser la classe TaskCategory
import 'package:tp_firebase/widgets/add_task_dialog.dart'; 

class TaskTile extends StatelessWidget {
  final QueryDocumentSnapshot taskDoc;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TaskTile({
    super.key,
    required this.taskDoc,
    required this.onToggle,
    required this.onDelete,
  });

  // Méthode utilitaire pour associer le nom de la catégorie à sa couleur
  Color _getCategoryColor(String categoryName) {
    final match = TaskCategory.categories.firstWhere(
      (cat) => cat.name == categoryName,
      orElse: () => const TaskCategory('Inconnu', Colors.grey),
    );
    return match.color;
  }

  @override
  Widget build(BuildContext context) {
    // Récupération sécurisée des données Firestore
    final data = taskDoc.data() as Map<String, dynamic>;
    final title = data['title'] ?? '';
    final isDone = data['done'] ?? false;
    final category = data['category'] ?? 'Personnel';
    final Timestamp? dueDateTimestamp = data['dueDate'];

    // Formatage de la date au format de lecture français
    String dateText = 'Pas de date';
    if (dueDateTimestamp != null) {
      final date = dueDateTimestamp.toDate();
      final day = date.day.toString().padLeft(2, '0');
      final month = date.month.toString().padLeft(2, '0');
      dateText = '$day/$month/${date.year}';
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: ListTile(
        leading: Checkbox(
          value: isDone,
          onChanged: (_) => onToggle(),
          activeColor: _getCategoryColor(category),
        ),
        title: Text(
          title,
          style: TextStyle(
            decoration: isDone ? TextDecoration.lineThrough : null,
            color: isDone ? Colors.grey : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        // Ajout du sous-titre affichant le badge de catégorie et l'échéance
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: _getCategoryColor(category),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$category • $dateText',
              style: TextStyle(
                color: isDone ? Colors.grey : Colors.black54,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
