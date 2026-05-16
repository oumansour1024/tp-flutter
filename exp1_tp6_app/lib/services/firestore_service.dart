import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Obtenir l'uid de l'utilisateur connecté
  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  // Stream des tâches de l'utilisateur (temps réel)
  Stream<QuerySnapshot> getTasksStream() {
    final uid = _uid;
    if (uid == null) return const Stream.empty();

    try {
      return _db
          .collection('tasks')
          .where('userId', isEqualTo: uid)
          .orderBy('createdAt', descending: true)
          .snapshots();
    } catch (e) {
      print('Erreur Firestore (index composite requis ?): $e');
      rethrow;
    }
  }

  // Ajouter une tâche
  Future<void> addTask(String title) async {
    final uid = _uid;
    if (uid == null) throw Exception('Utilisateur non connecté');
    try {
      await _db.collection('tasks').add({
        'title': title,
        'done': false,
        'userId': uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Erreur addTask: $e');
      rethrow;
    }
  }

  // Supprimer une tâche
  Future<void> deleteTask(String docId) async {
    try {
      await _db.collection('tasks').doc(docId).delete();
    } catch (e) {
      print('Erreur deleteTask: $e');
      rethrow;
    }
  }

  // Basculer l'état fait/non fait
  Future<void> toggleTask(String docId, bool currentValue) async {
    try {
      await _db.collection('tasks').doc(docId).update({'done': !currentValue});
    } catch (e) {
      print('Erreur toggleTask: $e');
      rethrow;
    }
  }
}
