class Etudiant {
  final String id;
  final String nom;
  final double note;
  

  Etudiant({
    required this.id,
    required this.nom,
    required this.note,
  });

  bool get estAdmis => note >= 10;
}