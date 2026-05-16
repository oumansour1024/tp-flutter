import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Obtenir l'uid de l'utilisateur connecté
  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  // Stream des tâches de l'utilisateur (temps réel)
  Stream<QuerySnapshot> getTasksStream() {
    return _db
        .collection('tasks')
        .where('userId', isEqualTo: _uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // Ajouter une tâche avec catégorie et date d'échéance
  Future<void> addTask({
    required String title,
    required String category,
    DateTime? dueDate,
  }) async {
    await _db.collection('tasks').add({
      'title': title,
      'done': false,
      'category': category,
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate) : null,
      'userId': _uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Supprimer une tâche
  Future<void> deleteTask(String docId) async {
    await _db.collection('tasks').doc(docId).delete();
  }

  // Basculer l'état fait/non fait
  Future<void> toggleTask(String docId, bool currentValue) async {
    await _db.collection('tasks').doc(docId).update({'done': !currentValue});
  }
}