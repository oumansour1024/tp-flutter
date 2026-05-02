class Post {
  final int id;
  final String title;
  final String body;
  final int userId;
  final String? imageUrl;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    this.imageUrl,
  });

  // Méthode utilitaire pour obtenir un résumé
  String get summary {
    if (body.length <= 100) return body;
    return '${body.substring(0, 100)}...';
  }

  @override
  String toString() {
    return 'Post(id: $id, title: $title, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Post && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}