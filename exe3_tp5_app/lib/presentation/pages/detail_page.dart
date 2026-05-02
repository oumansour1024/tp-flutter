import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/post_provider.dart';

class DetailPage extends StatefulWidget {
  final String id;

  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<void> _loadPostFuture;

  @override
  void initState() {
    super.initState();
    final postId = int.tryParse(widget.id);
    if (postId != null) {
      _loadPostFuture = context.read<PostProvider>().loadPostById(postId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final postId = int.tryParse(widget.id);

    if (postId == null) {
      return _buildErrorScaffold('ID d\'article invalide');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail de l\'article'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Consumer<PostProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Chargement de l\'article...'),
                ],
              ),
            );
          }

          if (provider.hasError) {
            return _buildErrorScaffold(provider.error!);
          }

          final post = provider.currentPost;
          if (post == null) {
            return _buildErrorScaffold('Article non trouvé');
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image (si disponible)
                if (post.imageUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      post.imageUrl!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 200,
                        color: Colors.grey.shade300,
                        child: const Center(child: Icon(Icons.broken_image, size: 50)),
                      ),
                    ),
                  ),

                const SizedBox(height: 20),

                // Métadonnées
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Article #${post.id}',
                    style: TextStyle(
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Titre
                Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                // Informations utilisateur
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      child: Icon(Icons.person, size: 16),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Utilisateur ${post.userId}',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),

                const Divider(height: 32),

                // Contenu
                Text(
                  post.body,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 32),

                // Boutons de navigation
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          context.pop();
                        },
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Retour'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context.go('/');
                        },
                        icon: const Icon(Icons.home),
                        label: const Text('Accueil'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Scaffold _buildErrorScaffold(String message) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Erreur'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Retour à l\'accueil'),
            ),
          ],
        ),
      ),
    );
  }
}