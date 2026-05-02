import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_model.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SetStatePage(),
  ));
}


class SetStatePage extends StatefulWidget {
  @override
  _SetStatePageState createState() => _SetStatePageState();
}

class _SetStatePageState extends State<SetStatePage> {
  List<User> users = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchUsers() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          users = data.map((json) => User.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Erreur lors du chargement des utilisateurs');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = " Erreur de Connexion API ";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Utilisateurs (setState)')),
      body: Center(
        child: _buildBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return CircularProgressIndicator();
    } else if (errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(errorMessage!, style: TextStyle(color: Colors.red)),
      );
    } else {
      return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(child: Text(user.name[0])),
            title: Text(user.name),
            subtitle: Text(user.email),
          );
        },
      );
    }
  }
}