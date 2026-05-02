import 'package:provider/provider.dart';


import '../../data/datasources/post_local_datasource.dart';
import '../../data/repositories/post_repository_impl.dart';
import '../../domain/repositories/post_repository.dart';
import '../../domain/usecases/get_posts_usecase.dart';
import '../../domain/usecases/get_post_by_id_usecase.dart';
import '../../presentation/providers/post_provider.dart';

/// Injection des dépendances
/// Centralise la création des objets
class DependencyInjection {
  /// Crée le provider principal avec ses dépendances
  static ChangeNotifierProvider<PostProvider> createPostProvider() {
    return ChangeNotifierProvider(
      create: (context) => _createPostProvider(),
    );
  }

  static PostProvider _createPostProvider() {
    // 1. Data Source
    final dataSource = PostLocalDataSource();

    // 2. Repository (implémentation)
    final PostRepository repository = PostRepositoryImpl(dataSource);

    // 3. Use Cases
    final getPostsUseCase = GetPostsUseCase(repository);
    final getPostByIdUseCase = GetPostByIdUseCase(repository);

    // 4. Provider
    return PostProvider(
      getPostsUseCase: getPostsUseCase,
      getPostByIdUseCase: getPostByIdUseCase,
    );
  }
}