import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// --- MODÈLE ---
class User {
  final String name;
  final String email;
  User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name'], email: json['email']);
  }
}

// --- LOGIQUE (PROVIDER) ---
// FutureProvider gère nativement le futur, le chargement et les erreurs.
final usersProvider = FutureProvider<List<User>>((ref) async {
  final response = await http.get(Uri.parse('https://typicode.com'));
  
  if (response.statusCode == 200) {
    List data = json.decode(response.body);
    return data.map((json) => User.fromJson(json)).toList();
  } else {
    throw Exception("Erreur lors de la récupération des utilisateurs");
  }
});

void main() {
  // Indispensable pour que Riverpod fonctionne
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// --- INTERFACE (CONSUMER WIDGET) ---
// On utilise ConsumerWidget pour avoir accès à l'objet "ref"
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // On écoute le provider
    final usersAsync = ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("TP4 : Riverpod (AsyncValue)"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(usersProvider), // Rafraîchissement facile
          ),
        ],
      ),
      // .when() force le traitement des 3 états obligatoirement
      body: usersAsync.when(
        data: (users) => ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) => ListTile(
            leading: CircleAvatar(child: Text(users[index].name[0])),
            title: Text(users[index].name),
            subtitle: Text(users[index].email),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Erreur: $err", style: const TextStyle(color: Colors.red)),
              ElevatedButton(
                onPressed: () => ref.refresh(usersProvider),
                child: const Text("Réessayer"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
