// lib/screens/layout_widgets_screen.dart
import 'package:flutter/material.dart';

class LayoutWidgetsScreen extends StatefulWidget {
  const LayoutWidgetsScreen({super.key});

  @override
  State<LayoutWidgetsScreen> createState() => _LayoutWidgetsScreenState();
}

class _LayoutWidgetsScreenState extends State<LayoutWidgetsScreen> {
  double _sliderValue = 50;
  bool _showLeftElement = true;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout Widgets'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Introduction
            _buildInfoCard(),
            const SizedBox(height: 24),
            
            // Row & Column
            _buildSectionTitle('Row & Column (Flexbox)', Icons.view_column),
            _buildRowColumnDemo(),
            const SizedBox(height: 24),
            
            // Stack
            _buildSectionTitle('Stack (Positioning)', Icons.layers),
            _buildStackDemo(),
            const SizedBox(height: 24),
            
            // Container vs Optimized
            _buildSectionTitle('Container & Optimized Alternatives', Icons.crop_square),
            _buildContainerComparison(),
            const SizedBox(height: 24),
            
            // Expanded & Flexible
            _buildSectionTitle('Expanded vs Flexible', Icons.aspect_ratio),
            _buildExpandedFlexibleDemo(),
            const SizedBox(height: 24),
            
            // Wrap
            _buildSectionTitle('Wrap (Auto Flow)', Icons.wrap_text),
            _buildWrapDemo(),
            const SizedBox(height: 24),
            
            // ListView & GridView
            _buildSectionTitle('ListView & GridView', Icons.list_alt),
            _buildListGridDemo(),
            const SizedBox(height: 24),
            
            // ConstrainedBox & SizedBox
            _buildSectionTitle('SizedBox & ConstrainedBox', Icons.aspect_ratio),
            _buildConstraintsDemo(),
            const SizedBox(height: 24),
            
            // CustomScrollView with Slivers
            _buildSectionTitle('CustomScrollView & Slivers', Icons.view_agenda),
            SizedBox(
              height: 300,
              child: _buildSliverDemo(),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widgets
  Widget _buildInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'Layout Widgets Overview',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Layout widgets control how other widgets are positioned, sized, and arranged on screen. '
              'They form the foundation of every Flutter UI.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                _buildInfoChip('Row/Column', Colors.blue),
                _buildInfoChip('Stack', Colors.green),
                _buildInfoChip('Wrap', Colors.orange),
                _buildInfoChip('ListView', Colors.purple),
                _buildInfoChip('Slivers', Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, Color color) {
    return Chip(
      label: Text(label),
      backgroundColor: color.withOpacity(0.2),
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Theme.of(context).primaryColor),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Row & Column Demo
  Widget _buildRowColumnDemo() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Row (Horizontal)',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Container(
            color: Colors.grey.shade100,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _DemoBox(color: Colors.red, size: 40),
                _DemoBox(color: Colors.green, size: 60),
                _DemoBox(color: Colors.blue, size: 30),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Column (Vertical)',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Container(
            color: Colors.grey.shade100,
            height: 150,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _DemoBox(color: Colors.red, size: 30),
                _DemoBox(color: Colors.green, size: 40),
                _DemoBox(color: Colors.blue, size: 35),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '💡 Row et Column sont les widgets de base du layout Flex.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Stack Demo
  Widget _buildStackDemo() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Background
                Container(
                  color: Colors.blue.shade100,
                ),
                // Positioned elements
                Positioned(
                  top: 10,
                  left: 10,
                  child: _DemoBox(color: Colors.red, size: 60),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: _DemoBox(color: Colors.green, size: 60),
                ),
                // Center element
                const Positioned(
                  top: 70,
                  left: 70,
                  child: _DemoBox(color: Colors.amber, size: 60),
                ),
                // Alignment using Align
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: _DemoBox(color: Colors.purple, size: 50),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '💡 Stack permet le positionnement absolu. Align pour le positionnement relatif.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Container Comparison
  Widget _buildContainerComparison() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('❌ Container (moins performant)'),
          const SizedBox(height: 8),
          Container(
            width: 100,
            height: 100,
            color: Colors.red,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(4),
          ),
          const SizedBox(height: 16),
          const Text('✅ Optimisé (SizedBox + ColoredBox)'),
          const SizedBox(height: 8),
          SizedBox(
            width: 100,
            height: 100,
            child: ColoredBox(
              color: Colors.green,
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Center(child: Text('Better')),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '💡 Préférez SizedBox/ColoredBox quand vous n\'avez pas besoin de decoration.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Expanded vs Flexible
  Widget _buildExpandedFlexibleDemo() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Expanded (prend tout l\'espace restant)'),
          const SizedBox(height: 8),
          Row(
            children: [
              _DemoBox(color: Colors.red, size: 50),
              Expanded(
                child: _DemoBox(color: Colors.blue, size: 50),
              ),
              _DemoBox(color: Colors.green, size: 50),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Flexible (peut prendre moins)'),
          const SizedBox(height: 8),
          Row(
            children: [
              _DemoBox(color: Colors.red, size: 50),
              Flexible(
                flex: 2,
                child: _DemoBox(color: Colors.blue, size: 50),
              ),
              Flexible(
                flex: 1,
                child: _DemoBox(color: Colors.green, size: 50),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '💡 Expanded force l\'enfant à remplir, Flexible permet de partager l\'espace.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Wrap Demo
  Widget _buildWrapDemo() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 12,
            children: List.generate(
              20,
              (index) => Chip(
                label: Text('Item $index'),
                backgroundColor: Colors.primaries[index % Colors.primaries.length]
                    .withOpacity(0.3),
                avatar: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.primaries[index % Colors.primaries.length],
                  child: Text(
                    '$index',
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '💡 Wrap passe automatiquement à la ligne quand l\'espace manque.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // ListView & GridView
  Widget _buildListGridDemo() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  width: 80,
                  margin: const EdgeInsets.only(right: 8),
                  color: Colors.primaries[index % Colors.primaries.length],
                  child: Center(child: Text('Item $index')),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.primaries[index % Colors.primaries.length],
                  child: Center(child: Text('$index')),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '💡 Utilisez .builder pour les grandes listes (lazy loading).',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Constraints Demo
  Widget _buildConstraintsDemo() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('SizedBox (taille fixe)'),
          const SizedBox(height: 8),
          const SizedBox(
            width: 100,
            height: 50,
            child: _DemoBox(color: Colors.orange),
          ),
          const SizedBox(height: 16),
          const Text('ConstrainedBox (contraintes min/max)'),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 100,
              maxWidth: 200,
              minHeight: 40,
              maxHeight: 80,
            ),
            child: Container(color: Colors.teal),
          ),
          const SizedBox(height: 8),
          const Text(
            '💡 Les contraintes sont passées du parent à l\'enfant.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Slivers Demo
  Widget _buildSliverDemo() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            collapsedHeight: 50,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Sliver App Bar'),
              background: Container(
                color: Colors.blue.shade200,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  leading: CircleAvatar(
                    child: Text('$index'),
                  ),
                  title: Text('Item $index'),
                  subtitle: Text('This is sliver list item $index'),
                ),
                childCount: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable demo box widget
class _DemoBox extends StatelessWidget {
  final Color color;
  final double size;

  const _DemoBox({
    required this.color,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: color,
      child: Center(
        child: Text(
          size.toStringAsFixed(0),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}