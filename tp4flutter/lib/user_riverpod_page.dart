import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'riverpod_providers.dart';
import 'user_model.dart';



class UserRiverpodPage extends StatelessWidget {
  const UserRiverpodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const RiverpodScreen(),
    );
  }
    
}

class RiverpodScreen extends ConsumerWidget {
  const RiverpodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Utilisation de ref.watch() pour écouter les changements
    final usersAsync = ref.watch(usersFutureProvider);
    // Alternative avec StateNotifierProvider:
    // final usersAsync = ref.watch(usersNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod - Gestion réactive'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Rafraîchir le FutureProvider
              ref.invalidate(usersFutureProvider);
              // Pour StateNotifierProvider:
              // ref.read(usersNotifierProvider.notifier).refreshUsers();
            },
            tooltip: 'Rafraîchir',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(usersFutureProvider);
          // Pour éviter d'attendre indéfiniment
          await Future.delayed(const Duration(milliseconds: 500));
        },
        // ==================== AsyncValue ====================
        // AsyncValue gère nativement les 3 états !
        child: usersAsync.when(
          // État de chargement
          loading: () => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Chargement des utilisateurs...'),
              ],
            ),
          ),
          // État d'erreur
          error: (error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text(
                  'Erreur: $error',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => ref.invalidate(usersFutureProvider),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Réessayer'),
                ),
              ],
            ),
          ),
          // État de succès (données disponibles)
          data: (users) {
            if (users.isEmpty) {
              return const Center(
                child: Text('Aucun utilisateur trouvé'),
              );
            }
            
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return _buildUserCard(ref, user);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserCard(WidgetRef ref, User user) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.purple.shade100,
          child: user.avatar != null
              ? ClipOval(
                  child: Image.network(
                    user.avatar!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.purple[700],
                    ),
                  ),
                )
              : Icon(Icons.person, size: 30, color: Colors.purple[700]),
        ),
        title: Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('${user.email}'),
          ],
        ),
        
      ),
    );
  }
}