import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Obtenir l'uid de l'utilisateur connecté
  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  // Stream des notes de l'utilisateur (temps réel)
  Stream<QuerySnapshot> getNotesStream() {
    return _db
        .collection('notes')
        .where('userId', isEqualTo: _uid)
        // .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // Ajouter une note
  Future<void> addNote({
    required String title,
    required String description,
  }) async {
    await _db.collection('notes').add({
      'title': title,
      'description': description,
      'userId': _uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Modifier une note
  Future<void> updateNote({
    required String docId,
    required String title,
    required String description,
  }) async {
    await _db.collection('notes').doc(docId).update({
      'title': title,
      'description': description,
    });
  }

  // Supprimer une note
  Future<void> deleteNote(String docId) async {
    await _db.collection('notes').doc(docId).delete();
  }
}