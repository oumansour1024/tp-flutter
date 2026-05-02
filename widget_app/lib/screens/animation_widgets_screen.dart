// lib/screens/animation_widgets_screen.dart
import 'package:flutter/material.dart';

class AnimationWidgetsScreen extends StatefulWidget {
  const AnimationWidgetsScreen({super.key});

  @override
  State<AnimationWidgetsScreen> createState() => _AnimationWidgetsScreenState();
}

class _AnimationWidgetsScreenState extends State<AnimationWidgetsScreen> {
  bool _isExpanded = false;
  double _opacity = 1.0;
  Color _color = Colors.blue;
  double _size = 100;

  final List<Color> _colors = [Colors.blue, Colors.red, Colors.green, Colors.orange];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animation Widgets')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('AnimatedContainer'),
            _buildAnimatedContainerDemo(),
            const SizedBox(height: 24),
            _buildSectionTitle('AnimatedOpacity & AnimatedSize'),
            _buildAnimatedOpacityDemo(),
            const SizedBox(height: 24),
            _buildSectionTitle('Hero Animation'),
            _buildHeroDemo(),
            const SizedBox(height: 24),
            _buildSectionTitle('TweenAnimationBuilder'),
            _buildTweenAnimationDemo(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAnimatedContainerDemo() {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: _size,
          height: _size,
          decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.circular(_isExpanded ? 50 : 10),
          ),
          curve: Curves.easeInOut,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: [
            ElevatedButton(
              onPressed: () => setState(() => _isExpanded = !_isExpanded),
              child: Text(_isExpanded ? 'Shrink' : 'Expand'),
            ),
            ElevatedButton(
              onPressed: () => setState(() {
                _color = _colors[(_colors.indexOf(_color) + 1) % _colors.length];
              }),
              child: const Text('Change Color'),
            ),
            ElevatedButton(
              onPressed: () => setState(() => _size = _size == 100 ? 150 : 100),
              child: const Text('Change Size'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnimatedOpacityDemo() {
    return Column(
      children: [
        AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: _opacity,
          child: Container(
            width: 200,
            height: 100,
            color: Colors.purple,
            child: const Center(child: Text('Fade me')),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => setState(() => _opacity = 1.0),
              child: const Text('Show'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () => setState(() => _opacity = 0.0),
              child: const Text('Hide'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroDemo() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const HeroDetailScreen(),
          ),
        );
      },
      child: Hero(
        tag: 'hero-widget',
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(blurRadius: 8)],
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, size: 48, color: Colors.white),
                Text('Tap me!', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTweenAnimationDemo() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 2),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.amber,
            child: const Center(child: Text('Scale me')),
          ),
        );
      },
    );
  }
}

// Hero detail screen
class HeroDetailScreen extends StatelessWidget {
  const HeroDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Detail')),
      body: Center(
        child: Hero(
          tag: 'hero-widget',
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, size: 80, color: Colors.white),
                  SizedBox(height: 16),
                  Text('Hero Animation!', style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}