import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const WidgetShowcaseApp());
}

class WidgetShowcaseApp extends StatelessWidget {
  const WidgetShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}