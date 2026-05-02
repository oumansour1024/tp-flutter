import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/etudiant_provider.dart';

class PageDetail extends StatelessWidget {
  final String id;

  const PageDetail({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<EtudiantProvider>(
      builder: (ctx, provider, _) {
        final etudiant = provider.etudiants.firstWhere(
          (e) => e.id == id,
          orElse: () => throw Exception('Étudiant non trouvé'),
        );

        return Scaffold(
          appBar: AppBar(
            title: Text(etudiant.nom),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          child: Text(
                            etudiant.nom[0].toUpperCase(),
                            style: const TextStyle(fontSize: 40),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          etudiant.nom,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        _infoRow('ID', etudiant.id),
                        _infoRow('Note', '${etudiant.note}/20'),
                        _infoRow(
                          'Statut',
                          etudiant.estAdmis ? 'Admis ✅' : 'Non admis ❌',
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          onPressed: () {
                            provider.supprimer(id);
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.delete),
                          label: const Text('Supprimer'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}