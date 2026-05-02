import 'package:flutter/material.dart';
import '../data/etudiant_model.dart';

class EtudiantProvider extends ChangeNotifier {
  final List<Etudiant> _etudiants = [];

  List<Etudiant> get etudiants => List.unmodifiable(_etudiants);

  int get total => _etudiants.length;

  int get admis => _etudiants.where((e) => e.estAdmis).length;

  double get tauxAdmission => total == 0 ? 0.0 : (admis / total) * 100;

  void ajouter(String nom, double note) {
    _etudiants.add(
      Etudiant(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        nom: nom,
        note: note,
      ),
    );
    notifyListeners();
  }

  void supprimer(String id) {
    _etudiants.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}