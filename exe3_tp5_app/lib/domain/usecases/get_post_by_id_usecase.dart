import '../repositories/post_repository.dart';
import '../entities/post.dart';

/// Cas d'utilisation : récupérer un article par son ID
class GetPostByIdUseCase {
  final PostRepository repository;

  GetPostByIdUseCase(this.repository);

  /// Exécute le cas d'utilisation
  /// Lance une exception si l'article n'existe pas
  Future<Post> execute(int id) async {
    if (id <= 0) {
      throw ArgumentError('ID invalide : $id');
    }

    final exists = await repository.exists(id);
    if (!exists) {
      throw Exception('Article avec l\'ID $id non trouvé');
    }

    return await repository.getPostById(id);
  }
}