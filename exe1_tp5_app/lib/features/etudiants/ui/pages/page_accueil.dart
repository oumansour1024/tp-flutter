import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/etudiant_provider.dart';
import '../widgets/carte_info.dart';

class PageAccueil extends StatelessWidget {
  const PageAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EtudiantProvider>(
      builder: (ctx, provider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tableau de bord'),
            centerTitle: true,
            elevation: 2,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                CarteInfo(
                  titre: 'Total étudiants',
                  valeur: '${provider.total}',
                  icone: Icons.people,
                  couleur: Colors.blue,
                ),
                CarteInfo(
                  titre: 'Étudiants admis',
                  valeur: '${provider.admis}',
                  icone: Icons.verified_user,
                  couleur: Colors.green,
                ),
                CarteInfo(
                  titre: "Taux d'admission",
                  valeur: '${provider.tauxAdmission.toStringAsFixed(1)}%',
                  icone: Icons.bar_chart,
                  couleur: Colors.orange,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => _ajouterExemple(provider),
                  icon: const Icon(Icons.add),
                  label: const Text('Ajouter étudiant exemple'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _ajouterExemple(EtudiantProvider provider) {
    provider.ajouter('Étudiant ${provider.total + 1}', randomNote());
  }
// Génère une note aléatoire entre 0 et 20  vers 20 plus souvent pour simuler des étudiants majoritairement admis
  double randomNote({double min = 0, double max = 20}) {
    final random = DateTime.now().millisecondsSinceEpoch % 100 / 100;
    return (random * (max - min) + min).clamp(min, max).toDouble();
  }
}