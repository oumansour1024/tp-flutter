
import 'package:go_router/go_router.dart';
import 'package:exe3_tp5_app/presentation/pages/home_page.dart';
import 'package:exe3_tp5_app/presentation/pages/detail_page.dart';
import 'package:exe3_tp5_app/presentation/pages/profile_page.dart';
import 'package:exe3_tp5_app/presentation/widgets/not_found_page.dart';

class AppRouter {
  // Routes nommées (centralisation)
  static const String home = '/';
  static const String detail = '/detail/:id';
  static const String profile = '/profile';

  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: home,

      // Gestion des erreurs 404
      errorBuilder: (context, state) {
        return NotFoundPage(requestedPath: state.uri.toString());
      },

      // Redirection (Guard)
      redirect: (context, state) {
        // Exemple de guard : protéger la route /profile
        // Ici on pourrait vérifier si l'utilisateur est connecté
        // Pour l'exemple, on laisse tout passer
        return null;
      },

      routes: [
        // Route Home
        GoRoute(
          path: home,
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),

        // Route Detail avec paramètre :id
        GoRoute(
          path: detail,
          name: 'detail',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return DetailPage(id: id);
          },
        ),

        // Route Profile
        GoRoute(
          path: profile,
          name: 'profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    );
  }
}