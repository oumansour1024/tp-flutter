import '../repositories/post_repository.dart';
import '../entities/post.dart';

/// Cas d'utilisation : récupérer tous les articles
/// Application de la règle métier
class GetPostsUseCase {
  final PostRepository repository;

  GetPostsUseCase(this.repository);

  /// Exécute le cas d'utilisation
  /// [forceRefresh] : si true, ignore le cache (optionnel)
  Future<List<Post>> execute({bool forceRefresh = false}) async {
    try {
      // Ici on pourrait implémenter du cache
      final posts = await repository.getPosts();

      // Règle métier : trier par ID décroissant (plus récent en premier)
      posts.sort((a, b) => b.id.compareTo(a.id));

      return posts;
    } catch (e) {
      // On pourrait logger l'erreur ici
      print('Erreur lors de la récupération des articles : $e');
      rethrow;
    }
  }
}