import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  final String title = "TP4 : API Users (setState)";

  @override
  State<HomePage> createState() => _HomePageState(); 
}

class _HomePageState extends State<HomePage> {
  // --- État de l'application ---
  List<dynamic> users = [];
  bool isLoading = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    fetchUsers(); // Chargement initial
  }

  // --- Logique métier (Asynchronisme) ---
  Future<void> fetchUsers() async {
    setState(() {
      isLoading = true;
      errorMessage = "";
    });

    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      
      if (response.statusCode == 200) {
        setState(() {
          users = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception("Erreur serveur : ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        errorMessage = "Impossible de charger les données : $e";
        isLoading = false;
      });
    }
  }

  // --- Interface Utilisateur ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchUsers, // Action de recharge
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage, textAlign: TextAlign.center, style: const TextStyle(color: Colors.red)),
            ElevatedButton(onPressed: fetchUsers, child: const Text("Réessayer")),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          leading: CircleAvatar(child: Text(user['name'][0])),
          title: Text(user['name']),
          subtitle: Text(user['email']),
        );
      },
    );
  }
}
