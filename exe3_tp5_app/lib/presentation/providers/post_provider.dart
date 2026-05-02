import 'package:flutter/material.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/get_posts_usecase.dart';
import '../../domain/usecases/get_post_by_id_usecase.dart';

/// Provider pour gérer l'état des articles
class PostProvider extends ChangeNotifier {
  final GetPostsUseCase _getPostsUseCase;
  final GetPostByIdUseCase _getPostByIdUseCase;

  // État
  List<Post> _posts = [];
  bool _isLoading = false;
  String? _error;
  Post? _currentPost;

  // Getters
  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Post? get currentPost => _currentPost;
  bool get hasPosts => _posts.isNotEmpty;
  bool get hasError => _error != null;

  PostProvider({
    required GetPostsUseCase getPostsUseCase,
    required GetPostByIdUseCase getPostByIdUseCase,
  })  : _getPostsUseCase = getPostsUseCase,
        _getPostByIdUseCase = getPostByIdUseCase;

  /// Charge tous les articles
  Future<void> loadPosts() async {
    if (_posts.isNotEmpty) return;

    _setLoading(true);
    _clearError();

    try {
      _posts = await _getPostsUseCase.execute();
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Rafraîchit la liste (force le rechargement)
  Future<void> refreshPosts() async {
    _setLoading(true);
    _clearError();

    try {
      _posts = await _getPostsUseCase.execute(forceRefresh: true);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Charge un article par son ID
  Future<Post?> loadPostById(int id) async {
    _setLoading(true);
    _clearError();
    _currentPost = null;

    try {
      _currentPost = await _getPostByIdUseCase.execute(id);
      notifyListeners();
      return _currentPost;
    } catch (e) {
      _setError(e.toString());
      return null;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }
}