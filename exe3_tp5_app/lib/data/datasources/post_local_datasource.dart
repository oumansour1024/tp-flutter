import '../../domain/entities/post.dart';

/// Source de données locale (simulation d'API)
/// En production, ici on aurait des appels HTTP ou SQLite
class PostLocalDataSource {
  // Liste statique des articles (simulation d'une base de données)
  static final List<Post> _posts = [
    Post(
      id: 1,
      title: 'Introduction à Flutter',
      body:
          'Flutter est un framework UI open-source créé par Google. Il permet de développer des applications pour mobile, web et desktop à partir d\'un seul codebase. Dans cet article, nous allons découvrir les bases de Flutter et comment démarrer votre premier projet.',
      userId: 1,
      imageUrl: 'https://picsum.photos/id/0/400/200',
    ),
    Post(
      id: 2,
      title: 'Clean Architecture expliquée',
      body:
          'La Clean Architecture, popularisée par Robert C. Martin, est une approche qui sépare le code en couches indépendantes. Les couches principales sont : Domain (règles métier), Data (implémentation technique) et Presentation (UI). Cette séparation facilite les tests et la maintenance.',
      userId: 1,
      imageUrl: 'https://picsum.photos/id/1/400/200',
    ),
    Post(
      id: 3,
      title: 'Provider vs Riverpod',
      body:
          'Provider et Riverpod sont deux solutions de gestion d\'état pour Flutter. Provider est plus simple et largement utilisé, tandis que Riverpod offre plus de flexibilité et résout certains problèmes de Provider comme la dépendance au contexte. Le choix dépend de la complexité de votre projet.',
      userId: 2,
      imageUrl: 'https://picsum.photos/id/2/400/200',
    ),
    Post(
      id: 4,
      title: 'GoRouter : Navigation avancée',
      body:
          'GoRouter est un package qui facilite la navigation dans Flutter. Il supporte les routes nommées, la redirection conditionnelle, les transitions personnalisées, et le deep linking. Contrairement au Navigator traditionnel, GoRouter centralise toute la configuration dans un seul fichier.',
      userId: 2,
      imageUrl: 'https://picsum.photos/id/3/400/200',
    ),
    Post(
      id: 5,
      title: 'Les meilleures pratiques Flutter 2025',
      body:
          'En 2025, plusieurs pratiques sont recommandées : utiliser des packages null-safe, adopter la Clean Architecture pour les projets complexes, privilégier GoRouter pour la navigation, et utiliser les cas d\'utilisation (use cases) pour séparer la logique métier. Découvrons tout cela en détail.',
      userId: 3,
      imageUrl: 'https://picsum.photos/id/4/400/200',
    ),
  ];

  /// Récupère tous les articles
  Future<List<Post>> getPosts() async {
    // Simulation d'un délai réseau
    await Future.delayed(const Duration(milliseconds: 500));
    return _posts;
  }

  /// Récupère un article par ID
  Future<Post> getPostById(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final post = _posts.firstWhere(
      (post) => post.id == id,
      orElse: () => throw Exception('Post non trouvé'),
    );
    return post;
  }

  /// Vérifie si un article existe
  Future<bool> exists(int id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _posts.any((post) => post.id == id);
  }
}