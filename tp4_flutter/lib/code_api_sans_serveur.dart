import 'package:flutter/material.dart';
//Code pour api sans server
void main() {
  runApp(const MonAppUtilisateurs());
}

class MonAppUtilisateurs extends StatelessWidget {
  const MonAppUtilisateurs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const PageUtilisateurs(),
    );
  }
}

class PageUtilisateurs extends StatefulWidget {
  const PageUtilisateurs({super.key});

  @override
  State<PageUtilisateurs> createState() => _PageUtilisateursState();
}

class _PageUtilisateursState extends State<PageUtilisateurs> {
  // Variables d'état
  List<String> _users = [];
  bool _loading = false;
  String _erreur = '';

  // 1. Simuler une liste d'utilisateurs (Logique métier)
  Future<List<String>> fetchUtilisateurs() async {
    // Simuler delai reseau (2 secondes)
    await Future.delayed(const Duration(seconds: 5));

    // Simuler echec reseau (Basé sur les secondes pour le test)
    if (DateTime.now().second % 2 == 0) {
      throw Exception('Le serveur est injoignable (Erreur simulée)');
    }

    // Retourner fausses donnees
    return ['Sara', 'Ahmed', 'Fatima', 'Youssef', 'Nadia'];
  }

  // 2. Gestion de l'appel asynchrone dans l'UI
  Future<void> _charger() async {
    setState(() {
      _loading = true;
      _erreur = ''; // Réinitialise l'erreur au début du chargement
    });

    try {
      final users = await fetchUtilisateurs();
      if (mounted) {
        setState(() {
          _users = users;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _erreur = e.toString();
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des Utilisateurs'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: _buildContent(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loading ? null : _charger,
        tooltip: 'Actualiser',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  // Widget helper pour organiser l'affichage selon l'état
  Widget _buildContent() {
    if (_loading) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 10),
          Text("Récupération des données..."),
        ],
      );
    }

    if (_erreur.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 60),
          const SizedBox(height: 10),
          Text(_erreur, textAlign: TextAlign.center, style: const TextStyle(color: Colors.red)),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _charger, child: const Text("Réessayer")),
        ],
      );
    }

    if (_users.isEmpty) {
      return const Text("Aucun utilisateur chargé. Cliquez sur le bouton.");
    }

    return ListView.separated(
      shrinkWrap: true, // Pour que la liste s'adapte à son contenu dans le Center
      itemCount: _users.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(child: Text(_users[index][0])),
          title: Text(_users[index]),
          subtitle: const Text("Utilisateur vérifié"),
        );
      },
    );
  }
}