
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'user_model.dart';


class UserProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  // ==================== ÉTATS ====================
  List<User> _users = [];
  bool _isLoading = false;
  String? _errorMessage;

  // ==================== GETTERS ====================
  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;
  bool get hasUsers => _users.isNotEmpty;

  // ==================== MÉTHODES MÉTIER ====================
  
  // Récupération des utilisateurs
  Future<void> fetchUsers() async {
    // Transition vers l'état de chargement
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); 

    try {
      final users = await _apiService.fetchUsersAlternative();
      
      
      _users = users;
      _isLoading = false;
      notifyListeners(); 
    } catch (e) {
      
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners(); 
    }
  }

 
  Future<void> refreshUsers() async {
    await fetchUsers();
  }

  
  void reset() {
    _users = [];
    _isLoading = false;
    _errorMessage = null;
    notifyListeners();
  }
}