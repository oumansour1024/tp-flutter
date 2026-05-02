import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../logic/etudiant_provider.dart';

class PageListe extends StatelessWidget {
  const PageListe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des étudiants'),
        centerTitle: true,
      ),
      body: Consumer<EtudiantProvider>(
        builder: (ctx, provider, _) {
          if (provider.etudiants.isEmpty) {
            return const Center(
              child: Text('Aucun étudiant pour le moment'),
            );
          }
          return ListView.builder(
            itemCount: provider.etudiants.length,
            itemBuilder: (ctx, index) {
              final etudiant = provider.etudiants[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(etudiant.nom[0].toUpperCase()),
                ),
                title: Text(etudiant.nom),
                subtitle: Text('Note: ${etudiant.note}'),
                trailing: Icon(
                  etudiant.estAdmis ? Icons.check_circle : Icons.cancel,
                  color: etudiant.estAdmis ? Colors.green : Colors.red,
                ),
                onTap: () {
                  context.push('/liste/detail/${etudiant.id}');
                },
              );
            },
          );
        },
      ),
    );
  }
}