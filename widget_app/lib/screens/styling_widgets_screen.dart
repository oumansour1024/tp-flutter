// lib/screens/styling_widgets_screen.dart
import 'package:flutter/material.dart';

class StylingWidgetsScreen extends StatelessWidget {
  const StylingWidgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Styling Widgets')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Text & RichText'),
            _buildTextDemo(),
            const SizedBox(height: 24),
            _buildSectionTitle('Images'),
            _buildImageDemo(),
            const SizedBox(height: 24),
            _buildSectionTitle('Icons'),
            _buildIconDemo(),
            const SizedBox(height: 24),
            _buildSectionTitle('Chips'),
            _buildChipDemo(),
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

  Widget _buildTextDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Simple Text',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'Bold Large Text',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 16, color: Colors.black),
            children: [
              TextSpan(text: 'This is ', style: TextStyle(fontWeight: FontWeight.normal)),
              TextSpan(text: 'RichText', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              TextSpan(text: ' with multiple styles'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        DefaultTextStyle(
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('This text inherits style'),
              Text('So does this one'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageDemo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage('https://picsum.photos/200'),
          child: Text('Fallback'),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            'https://picsum.photos/100',
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.grey[300],
          child: const Icon(Icons.image, size: 40),
        ),
      ],
    );
  }

  Widget _buildIconDemo() {
    return Wrap(
      spacing: 16,
      children: const [
        Icon(Icons.favorite, color: Colors.red, size: 40),
        Icon(Icons.star, color: Colors.amber, size: 40),
        Icon(Icons.home, color: Colors.blue, size: 40),
        Icon(Icons.settings, color: Colors.grey, size: 40),
      ],
    );
  }

  Widget _buildChipDemo() {
    return Wrap(
      spacing: 8,
      children: [
        const Chip(
          label: Text('Basic Chip'),
          avatar: Icon(Icons.person, size: 18),
        ),
        Chip(
          label: const Text('Deletable Chip'),
          onDeleted: () {},
          deleteIcon: const Icon(Icons.close, size: 18),
        ),
        InputChip(
          label: const Text('Input Chip'),
          selected: true,
          onSelected: (selected) {},
        ),
        FilterChip(
          label: const Text('Filter Chip'),
          selected: false,
          onSelected: (selected) {},
        ),
      ],
    );
  }
}