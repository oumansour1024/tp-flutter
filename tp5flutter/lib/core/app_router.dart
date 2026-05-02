import 'package:go_router/go_router.dart';
import 'package:tp5flutter/features/etudiants/ui/home_page.dart';
import 'package:tp5flutter/features/etudiants/ui/lists_page.dart';
import 'package:tp5flutter/features/etudiants/ui/profile_page.dart';
import 'package:tp5flutter/features/etudiants/ui/main_screen.dart';


class AppRouter {
  static final router = GoRouter(
    initialLocation: '/home', // Optionnel : définit la page de démarrage
    routes: [
      ShellRoute(
        // Le builder définit l'enveloppe (le "Shell") autour des routes enfants
        builder: (context, state, child) {
          return MainScreen(child: child); // Votre widget avec la navigation
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomePage(title: 'Home'),
          ),
          GoRoute(
            path: '/lists',
            builder: (context, state) => const ListsPage(title: 'Lists'),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfilePage(title: 'Profile'),
          ),
        ],
      ),
    ],
  );
}
