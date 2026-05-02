import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'user_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider()..fetchUsers(), // Initialise et charge les données
      child: MaterialApp(
        home: UserProviderPage(),
        debugShowCheckedModeBanner: false,
        ),
    ),
  );
}

class UserProviderPage extends StatelessWidget {
  UserProviderPage({super.key});

  @override
  Widget build(BuildContext context) {

    final userProvider = context.watch<UserProvider>();

  ;

    return Scaffold(
      appBar: AppBar(
        title: Text("Gestion d'état : Provider"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => context.read<UserProvider>().fetchUsers(), // Appel sans écoute
          ),
        ],
      ),
      body: _buildBody(userProvider),
    );
  }

  Widget _buildBody(UserProvider provider) {
    if (provider.isLoading) {
      return Center(child: CircularProgressIndicator()); // État chargement
    }

    if (provider.errorMessage != null) {
      return Center(child: Text(provider.errorMessage!, style: TextStyle(color: Colors.red)));
    }

    return ListView.builder(
      itemCount: provider.users.length,
      itemBuilder: (context, index) {
        final user = provider.users[index];
        return ListTile(
          leading: CircleAvatar(child: Text(user.name[0])),
          title: Text(user.name),
          subtitle: Text(user.email),
          trailing: user.phone != null ? Text(user.phone!) : null,


        );
      },
    );
  }
}

class UserProvider extends ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters pour exposer les données sans permettre de modification directe
  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUsers() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); 

    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _users = data.map((json) => User.fromJson(json)).toList();
      } else {
        _errorMessage = "Erreur lors de la récupération : ${response.statusCode}";
      }
    } catch (e) {
      _errorMessage = "Une erreur réseau est survenue.";
    } finally {
      _isLoading = false;
      notifyListeners(); // Informe l'UI du succès ou de l'échec
    }
  }
}