// lib/screens/layout_widgets_screen.dart
import 'package:flutter/material.dart';

class LayoutWidgetsScreen extends StatelessWidget {
  const LayoutWidgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Layout Widgets')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Row & Column'),
            _buildRowColumnDemo(),
            const SizedBox(height: 24),
            _buildSectionTitle('Stack'),
            _buildStackDemo(),
            const SizedBox(height: 24),
            _buildSectionTitle('Container vs ConstrainedBox'),
            _buildContainerDemo(),
            const SizedBox(height: 24),
            _buildSectionTitle('Wrap'),
            _buildWrapDemo(),
            const SizedBox(height: 24),
            _buildSectionTitle('Expanded & Flexible'),
            _buildExpandedDemo(),
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
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRowColumnDemo() {
    return Column(
      children: [
        Container(
          color: Colors.grey[200],
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.star, color: Colors.red, size: 30),
              Icon(Icons.star, color: Colors.green, size: 30),
              Icon(Icons.star, color: Colors.blue, size: 30),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              Container(color: Colors.red, width: 50, height: 30),
              Container(color: Colors.green, width: 50, height: 30),
              Container(color: Colors.blue, width: 50, height: 30),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStackDemo() {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Container(color: Colors.blue[100]),
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              color: Colors.red,
              width: 80,
              height: 80,
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              color: Colors.green,
              width: 80,
              height: 80,
            ),
          ),
          const Center(
            child: Icon(Icons.star, size: 50, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildContainerDemo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 100,
          height: 100,
          color: Colors.red,
          child: const Center(child: Text('Container')),
        ),
        const SizedBox(
          width: 100,
          height: 100,
          child: ColoredBox(
            color: Colors.green,
            child: Center(child: Text('SizedBox + ColoredBox')),
          ),
        ),
      ],
    );
  }

  Widget _buildWrapDemo() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
        15,
        (index) => Chip(
          label: Text('Item $index'),
          backgroundColor: Colors.primaries[index % Colors.primaries.length],
        ),
      ),
    );
  }

  Widget _buildExpandedDemo() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(color: Colors.red, height: 50),
        ),
        Expanded(
          flex: 2,
          child: Container(color: Colors.green, height: 50),
        ),
        Expanded(
          flex: 1,
          child: Container(color: Colors.blue, height: 50),
        ),
      ],
    );
  }
}