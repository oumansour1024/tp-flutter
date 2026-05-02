import 'package:flutter/material.dart';

class CarteInfo extends StatelessWidget {
  final String titre;
  final String valeur;
  final IconData icone;
  final Color? couleur;

  const CarteInfo({
    super.key,
    required this.titre,
    required this.valeur,
    required this.icone,
    this.couleur,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icone, size: 40, color: couleur ?? Colors.blue),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titre,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  valeur,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}