import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PageFutureBuilder(),
  ));
}

class PageFutureBuilder extends StatefulWidget {
  const PageFutureBuilder({super.key});

  @override
  State<PageFutureBuilder> createState() => _PageFutureBuilderState();
}

class _PageFutureBuilderState extends State<PageFutureBuilder> {
  // On stocke le Future dans une variable pour éviter les re-chargements inutiles
  late Future<List<String>> _futureUtilisateurs;

  @override
  void initState() {
    super.initState();
    _futureUtilisateurs = fetchUtilisateurs();
  }

  // Fonction de simulation identique à votre exemple
  Future<List<String>> fetchUtilisateurs() async {
    await Future.delayed(const Duration(seconds: 10));

    // Simuler échec si la seconde est un multiple de 5
    if (DateTime.now().second % 5 == 0) {
      throw Exception('Serveur injoignable');
    }

    return ['Sara', 'Ahmed', 'Fatima', 'Youssef', 'Nadia'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exemple FutureBuilder')),
      body: FutureBuilder<List<String>>(
        future: _futureUtilisateurs,
        builder: (context, snapshot) {
          
          // 1. État : En cours de chargement
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // 2. État : Erreur
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 48),
                  const SizedBox(height: 10),
                  Text(
                    '${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // On relance le Future
                        _futureUtilisateurs = fetchUtilisateurs();
                      });
                    },
                    child: const Text('Réessayer'),
                  ),
                ],
              ),
            );
          }

          // 3. État : Données disponibles
          if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  child: Text(users[index][0]),
                ),
                title: Text(users[index]),
              ),
            );
          }

          // Cas par défaut (liste vide ou autre)
          return const Center(child: Text("Aucune donnée"));
        },
      ),
    );
  }
}