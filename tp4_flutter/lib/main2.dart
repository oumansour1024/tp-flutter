import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// --- 1. LE MODÈLE DE DONNÉES ---
class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? 'Nom inconnu',
      email: json['email'] ?? 'Email inconnu',
    );
  }
}

// --- 2. LE PROVIDER (Logique métier et gestion d'état) ---
class UserProvider extends ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;
  String _errorMessage = "";

  // Getters pour exposer les variables en lecture seule
  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchUsers() async {
    _isLoading = true;
    _errorMessage = "";
    notifyListeners(); // Informe l'UI qu'on commence le chargement

    try {
      final response = await http.get(Uri.parse('https://typicode.com'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _users = data.map((json) => User.fromJson(json)).toList();
      } else {
        _errorMessage = "Erreur serveur : ${response.statusCode}";
      }
    } catch (e) {
      _errorMessage = "Erreur réseau : Vérifiez votre connexion.";
    } finally {
      _isLoading = false;
      notifyListeners(); // Informe l'UI que l'opération est terminée
    }
  }
}

// --- 3. L'APPLICATION (Point d'entrée) ---
void main() {
  runApp(
    // Injection du Provider au sommet de l'arbre
    ChangeNotifierProvider(
      create: (context) => UserProvider()..fetchUsers(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const HomePage(),
    );
  }
}

// --- 4. L'INTERFACE UTILISATEUR (Vue) ---
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Écoute du provider : le widget se reconstruira dès que notifyListeners() est appelé
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("TP4 : Version Provider"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<UserProvider>().fetchUsers(),
          ),
        ],
      ),
      body: _buildUI(userProvider),
    );
  }

  Widget _buildUI(UserProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(provider.errorMessage, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => provider.fetchUsers(),
              child: const Text("Réessayer"),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => provider.fetchUsers(),
      child: ListView.builder(
        itemCount: provider.users.length,
        itemBuilder: (context, index) {
          final user = provider.users[index];
          return ListTile(
            leading: CircleAvatar(child: Text(user.name[0])),
            title: Text(user.name),
            subtitle: Text(user.email),
          );
        },
      ),
    );
  }
}
