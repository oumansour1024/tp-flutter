// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_model.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/users';
  static const String alternativeBaseUrl = 'https://dummyjson.com/user';
  static const String avatarBaseUrl = 'https://i.pravatar.cc/150?img=';

  // Récupération des utilisateurs
  Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => User.fromJsonPlaceholder(json)).toList();
      } else {
        throw Exception('Erreur HTTP: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Impossible de récupérer les utilisateurs: $e');
    }
  }

  // Récupération des utilisateurs depuis une autre API (optionnel)
  Future<List<User>> fetchUsersAlternative() async {
    try {
      final response = await http.get(Uri.parse(alternativeBaseUrl));
      
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> usersData = data['users'] ?? [];
        return usersData.map((json) => User.fromDummyJson(json)).toList();
      } else {
        throw Exception('Erreur HTTP: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Impossible de récupérer les utilisateurs: $e');
    }
  }
}