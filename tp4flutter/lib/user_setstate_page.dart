import 'package:flutter/material.dart';
import 'api_service.dart';
import 'user_model.dart';

class UserSetStatePage extends StatefulWidget {
  const UserSetStatePage({super.key});

  @override
  State<UserSetStatePage> createState() => _UserSetStatePageState();
}

class _UserSetStatePageState extends State<UserSetStatePage> {
  
  List<User> _users = [];
  bool _isLoading = true;
  String? _errorMessage;

  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final users = await _apiService.fetchUsers();
      
      // Transition vers l'état de succès
      setState(() {
        _users = users;
        _isLoading = false;
      });
    } catch (e) {
      // Transition vers l'état d'erreur
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshUsers() async {
    await _fetchUsers();
  }


 
  @override
  Widget build(BuildContext context) {
    print("Rebuild de UserSetStatePage");
    return Scaffold(
      appBar: AppBar(
        title: const Text('setState() - Gestion locale'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshUsers,
            tooltip: 'Rafraîchir',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshUsers,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    // Gestion de l'état de chargement
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Chargement des utilisateurs...'),
          ],
        ),
      );
    }

    // Gestion de l'état d'erreur
    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              'Erreur: $_errorMessage',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _refreshUsers,
              icon: const Icon(Icons.refresh),
              label: const Text('Réessayer'),
            ),
          ],
        ),
      );
    }

    // Gestion de l'état de succès (affichage des données)
    if (_users.isEmpty) {
      return const Center(
        child: Text('Aucun utilisateur trouvé'),
      );
    }

    return ListView.builder(
      itemCount: _users.length,
      itemBuilder: (context, index) {
        final user = _users[index];
        return _buildUserCard(user);
      },
    );
  }

  Widget _buildUserCard(User user) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.orange.shade100,
          child: ClipOval(
            child: Image.network(
              user.avatar ?? '',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              // 1. Handles the "HTTP request failed" error shown in your image
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.person, size: 30, color: Colors.orange[700]);
              },
              // 2. Shows a progress indicator while the image is downloading
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
        ),

        title: Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(' ${user.email}'),
          ],
        ),
      ),
    );
  }
}