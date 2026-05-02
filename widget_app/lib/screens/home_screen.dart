// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../widgets/category_card.dart';
import 'layout_widgets_screen.dart';
import 'styling_widgets_screen.dart';
import 'interactive_widgets_screen.dart';
import 'animation_widgets_screen.dart';
import 'advanced_widgets_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<CategoryModel> categories = const [
    CategoryModel(
      title: 'Layout Widgets',
      icon: Icons.view_quilt,
      description: 'Row, Column, Stack, Container, etc.',
      color: Colors.blue,
    ),
    CategoryModel(
      title: 'Styling Widgets',
      icon: Icons.format_paint,
      description: 'Text, Image, Icon, Chip, etc.',
      color: Colors.green,
    ),
    CategoryModel(
      title: 'Interactive Widgets',
      icon: Icons.touch_app,
      description: 'Buttons, GestureDetector, TextField',
      color: Colors.orange,
    ),
    CategoryModel(
      title: 'Animation Widgets',
      icon: Icons.animation,
      description: 'AnimatedContainer, Hero, Transitions',
      color: Colors.purple,
    ),
    CategoryModel(
      title: 'Advanced Widgets',
      icon: Icons.code,
      description: 'FutureBuilder, StreamBuilder, Slivers',
      color: Colors.red,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Showcase'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return CategoryCard(
              title: category.title,
              icon: category.icon,
              description: category.description,
              color: category.color,
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LayoutWidgetsScreen(),
                      ),
                    );
                    break;
                  case 1:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const StylingWidgetsScreen(),
                      ),
                    );
                    break;
                  case 2:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const InteractiveWidgetsScreen(),
                      ),
                    );
                    break;
                  case 3:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AnimationWidgetsScreen(),
                      ),
                    );
                    break;
                  case 4:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AdvancedWidgetsScreen(),
                      ),
                    );
                    break;
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class CategoryModel {
  final String title;
  final IconData icon;
  final String description;
  final Color color;

  const CategoryModel({
    required this.title,
    required this.icon,
    required this.description,
    required this.color,
  });
}