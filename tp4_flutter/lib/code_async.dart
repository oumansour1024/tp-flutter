import 'package:flutter/material.dart';

void main() {
  runApp(const MonAppAsynchrone());
}

class MonAppAsynchrone extends StatelessWidget {
  const MonAppAsynchrone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const PageDonnees(),
    );
  }
}

class PageDonnees extends StatefulWidget {
  const PageDonnees({super.key});

  @override
  State<PageDonnees> createState() => _PageDonneesState();
}

class _PageDonneesState extends State<PageDonnees> {
  bool _chargement = false;
  String _resultat = 'Appuyez pour charger';

  Future<void> _chargerDonnees() async {
    // 1. Afficher le spinner (chargement en cours)
    setState(() {
      _chargement = true;
    });

    try {
      // 2. Simuler un appel réseau (3 secondes)
      await Future.delayed(const Duration(seconds: 10));
      const data = 'Données reçues avec succès !';

      // 3. Mettre à jour l'écran si le widget est toujours affiché
      if (mounted) { //Il est indispensable de vérifier mounted avant un setState() pour éviter de mettre à jour un widget déjà détruit.
        setState(() {
          _resultat = data;
          _chargement = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _resultat = 'Erreur : $e';
          _chargement = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exemple Asynchrone')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Zone d'affichage dynamique
              SizedBox(
                height: 100,
                child: Center(
                  child: _chargement
                      ? const CircularProgressIndicator()
                      : Text(
                          _resultat,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                        ),
                ),
              ),
              const SizedBox(height: 30),
              // Bouton d'action
              ElevatedButton.icon(
                onPressed: _chargement ? null : _chargerDonnees, // Désactivé pendant le chargement
                icon: const Icon(Icons.download),
                label: const Text('Charger les données'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}