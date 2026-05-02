import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_local_datasource.dart';

/// Implémentation concrète du repository
/// C'est ici qu'on choisit la source de données (local, API, etc.)
class PostRepositoryImpl implements PostRepository {
  final PostLocalDataSource dataSource;

  PostRepositoryImpl(this.dataSource);

  @override
  Future<List<Post>> getPosts() async {
    try {
      return await dataSource.getPosts();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des articles: $e');
    }
  }

  @override
  Future<Post> getPostById(int id) async {
    try {
      return await dataSource.getPostById(id);
    } catch (e) {
      throw Exception('Erreur lors de la récupération de l\'article $id: $e');
    }
  }

  @override
  Future<bool> exists(int id) async {
    try {
      return await dataSource.exists(id);
    } catch (e) {
      return false;
    }
  }
}