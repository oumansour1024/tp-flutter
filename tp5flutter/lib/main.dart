import 'package:flutter/material.dart';
import 'package:tp5flutter/core/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp.router(
     theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue, // Plus moderne que primarySwatch en Material 3
        brightness: Brightness.light,
        
        // Personnalisation de la barre de navigation du ShellRoute
        navigationBarTheme: NavigationBarThemeData(
          indicatorColor: Colors.blue.withOpacity(0.2),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),

        // Style des AppBar (en-têtes de vos pages Home, Lists, Profile)
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white, // Texte et icônes en blanc
          elevation: 0,
        ),

        // Style des boutons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
      ),

      
      routerConfig: AppRouter.router, 
    );
  }
}
