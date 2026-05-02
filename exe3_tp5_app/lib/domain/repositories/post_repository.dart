import '../entities/post.dart';

/// Repository abstrait (contrat)
/// La couche Domain ne dépend d'aucune autre couche
abstract class PostRepository {
  /// Récupère tous les articles
  Future<List<Post>> getPosts();

  /// Récupère un article par son ID
  /// Lance une exception si l'article n'existe pas
  Future<Post> getPostById(int id);

  /// Vérifie si un article existe
  Future<bool> exists(int id);
}