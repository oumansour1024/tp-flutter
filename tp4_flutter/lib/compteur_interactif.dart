import 'package:flutter/material.dart';
// Code Compteur interactif avec historique, pour voir le fonctionement de la fonction setState()  

void main() {
  runApp(const MonAppCompteur());
}

/// Point d'entrée de l'application
class MonAppCompteur extends StatelessWidget {
  const MonAppCompteur({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Démo Compteur',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const PageCompteur(),
    );
  }
}

/// Widget avec état (Stateful) pour gérer les données qui changent
class PageCompteur extends StatefulWidget {
  const PageCompteur({super.key});

  @override
  State<PageCompteur> createState() => _PageCompteurState();
}

class _PageCompteurState extends State<PageCompteur> {
  // --- Variables d'état ---
  int _compteur = 0;
  bool _estPositif = true;
  String _historique = '';

  // --- Logique métier ---

  /// Augmente la valeur et met à jour l'interface
  void _incrementer() {
    setState(() {
      _compteur++;
      _estPositif = _compteur >= 0;
      _historique += '+1  ';
    });
  }

  /// Diminue la valeur et met à jour l'interface
  void _decrementer() {
    setState(() {
      _compteur--;
      _estPositif = _compteur >= 0;
      _historique += '-1  ';
    });
  }

  /// Remet tout à zéro
  void _reinitialiser() {
    setState(() {
      _compteur = 0;
      _estPositif = true;
      _historique = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compteur Interactif'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Affichage du score avec changement de couleur dynamique
            Text(
              '$_compteur',
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: _estPositif ? Colors.green : Colors.red,
              ),
            ),
            
            // Affichage de l'historique des clics
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                _historique.isEmpty ? 'Aucune activité' : _historique,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14, 
                  color: Colors.grey,
                  fontStyle: FontStyle.italic
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Barre d'actions (Boutons)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Bouton Moins
                FloatingActionButton(
                  onPressed: _decrementer,
                  heroTag: "btn1",
                  child: const Icon(Icons.remove),
                ),
                
                const SizedBox(width: 20),
                
                // Bouton Réinitialiser (Style texte)
                ElevatedButton.icon(
                  onPressed: _reinitialiser,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.orange,
                  ),
                ),
                
                const SizedBox(width: 20),
                
                // Bouton Plus
                FloatingActionButton(
                  onPressed: _incrementer,
                  heroTag: "btn2",
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}