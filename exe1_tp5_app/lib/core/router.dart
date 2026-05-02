import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/etudiants/ui/pages/page_accueil.dart';
import '../features/etudiants/ui/pages/page_liste.dart';
import '../features/etudiants/ui/pages/page_detail.dart';
import '../features/etudiants/ui/pages/page_profil.dart';
import '../features/etudiants/ui/widgets/scaffold_with_navbar.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'accueil',
          builder: (context, state) => const PageAccueil(),
        ),
        GoRoute(
          path: '/liste',
          name: 'liste',
          builder: (context, state) => const PageListe(),
          routes: [
            GoRoute(
              path: 'detail/:id',
              name: 'detail',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return PageDetail(id: id);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/profil',
          name: 'profil',
          builder: (context, state) => const PageProfil(),
        ),
      ],
    ),
  ],
);