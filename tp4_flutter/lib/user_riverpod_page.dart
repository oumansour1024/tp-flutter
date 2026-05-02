import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_model.dart'; 

// 1. Déclaration du provider GLOBAL (doit être en dehors des classes)
final usersProvider = FutureProvider<List<User>>((ref) async {
  try {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      // Handles server-side errors (404, 500, etc.)
      throw Exception("Erreur lors de la récupération : ${response.statusCode}");
    }
  } catch (e) {
    // Handles network errors (DNS, timeout, etc.)
    throw Exception("Erreur connection API ");
  }
});


void main() {
  runApp(
    const ProviderScope( // Indispensable pour initialiser Riverpod
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: UserRiverpodPage(),
    );
  }
}

// 2. Utilisation de ConsumerWidget pour accéder au WidgetRef
class UserRiverpodPage extends ConsumerWidget {
  const UserRiverpodPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 3. Écoute réactive du provider via AsyncValue
    final usersAsync = ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion d'état : Riverpod"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            // Déclenche un nouveau chargement asynchrone[cite: 1]
            onPressed: () => ref.refresh(usersProvider),
          ),
        ],
      ),
      // 4. Gestion native des 3 états (loading, error, data)[cite: 1]
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
              const Icon(Icons.error_outline, color: Colors.red, size: 40),
              const SizedBox(height: 10),
              Text("Erreur : ${err.toString()}"),
            ],
          ),
        ),
      ),
    );
  }
}