import 'package:flutter_riverpod/legacy.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_service.dart';
import 'user_model.dart';




// Provider simple pour le service API
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// FutureProvider pour la gestion asynchrone native
// AsyncValue gère automatiquement les états: loading, error, data
final usersFutureProvider = FutureProvider<List<User>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.fetchUsers();
});

// StateNotifierProvider pour plus de contrôle (optionnel)
class UsersNotifier extends StateNotifier<AsyncValue<List<User>>> {
  UsersNotifier() : super(const AsyncValue.loading()) {
    fetchUsers();
  }

  final ApiService _apiService = ApiService();

  Future<void> fetchUsers() async {
    state = const AsyncValue.loading();
    
    try {
      final users = await _apiService.fetchUsers();
      state = AsyncValue.data(users);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshUsers() async {
    await fetchUsers();
  }
}

final usersNotifierProvider = StateNotifierProvider<UsersNotifier, AsyncValue<List<User>>>((ref) {
  return UsersNotifier();
});