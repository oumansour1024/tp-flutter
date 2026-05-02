import 'package:flutter/material.dart';
import 'user_model.dart';
import 'user_provider.dart';
import 'package:provider/provider.dart';


class UserProviderPage extends StatelessWidget {
  const UserProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider()..fetchUsers(),
      child: const _ProviderScreenContent(),
    );
  }
}

class _ProviderScreenContent extends StatelessWidget {
  const _ProviderScreenContent();

  @override
  Widget build(BuildContext context) {
    print("Rebuild de UserProviderPage");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider - Gestion centralisée'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<UserProvider>().refreshUsers();
            },
            tooltip: 'Rafraîchir',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<UserProvider>().refreshUsers(),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            // Gestion de l'état de chargement
            if (userProvider.isLoading && userProvider.users.isEmpty) {
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
            if (userProvider.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                    const SizedBox(height: 16),
                    Text(
                      'Erreur: ${userProvider.errorMessage}',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () => userProvider.refreshUsers(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Réessayer'),
                    ),
                  ],
                ),
              );
            }

            // Gestion de l'état de succès (affichage des données)
            if (!userProvider.hasUsers) {
              return const Center(
                child: Text('Aucun utilisateur trouvé'),
              );
            }

            return ListView.builder(
              itemCount: userProvider.users.length,
              itemBuilder: (context, index) {
                final user = userProvider.users[index];
                return _buildUserCard(context, user);
              },
            );
          },
        ),
      ),
    );
  }


    Widget _buildUserCard(BuildContext context,User user) {
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