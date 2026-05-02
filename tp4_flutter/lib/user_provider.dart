import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_model.dart';

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