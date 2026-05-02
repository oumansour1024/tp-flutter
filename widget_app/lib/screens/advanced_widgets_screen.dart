// lib/screens/advanced_widgets_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';

class AdvancedWidgetsScreen extends StatefulWidget {
  const AdvancedWidgetsScreen({super.key});

  @override
  State<AdvancedWidgetsScreen> createState() => _AdvancedWidgetsScreenState();
}

class _AdvancedWidgetsScreenState extends State<AdvancedWidgetsScreen> {
  final StreamController<int> _streamController = StreamController<int>();
  int _counter = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _streamController.add(_counter++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Advanced Widgets')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('FutureBuilder'),
            _buildFutureBuilderDemo(),
            const SizedBox(height: 24),
            _buildSectionTitle('StreamBuilder'),
            _buildStreamBuilderDemo(),
            const SizedBox(height: 24),
            _buildSectionTitle('LayoutBuilder & OrientationBuilder'),
            _buildLayoutBuilderDemo(),
            const SizedBox(height: 24),
            _buildSectionTitle('MediaQuery & SafeArea'),
            _buildMediaQueryDemo(),
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

  Widget _buildFutureBuilderDemo() {
    Future<String> fetchData() async {
      await Future.delayed(const Duration(seconds: 2));
      return 'Data loaded successfully!';
    }

    return FutureBuilder<String>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return Container(
          padding: const EdgeInsets.all(16),
          color: Colors.green[100],
          child: Text(snapshot.data ?? 'No data'),
        );
      },
    );
  }

  Widget _buildStreamBuilderDemo() {
    return StreamBuilder<int>(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return const Text('Waiting for data...');
        }
        return Container(
          padding: const EdgeInsets.all(16),
          color: Colors.orange[100],
          child: Column(
            children: [
              Text('Stream value: ${snapshot.data}', style: const TextStyle(fontSize: 24)),
              const Text('Counter increments every second'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLayoutBuilderDemo() {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue[100],
              child: Column(
                children: [
                  Text('Max Width: ${constraints.maxWidth.toStringAsFixed(0)}'),
                  Text('Max Height: ${constraints.maxHeight.toStringAsFixed(0)}'),
                  const SizedBox(height: 8),
                  Container(
                    width: constraints.maxWidth * 0.5,
                    height: 50,
                    color: Colors.blue,
                    child: const Center(child: Text('50% width')),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        OrientationBuilder(
          builder: (context, orientation) {
            return Container(
              padding: const EdgeInsets.all(16),
              color: Colors.purple[100],
              child: Text(
                'Orientation: ${orientation == Orientation.portrait ? 'Portrait' : 'Landscape'}',
                style: const TextStyle(fontSize: 16),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMediaQueryDemo() {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;

    return Column(
      children: [
        SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
            child: Column(
              children: [
                Text('Screen Size: ${size.width.toStringAsFixed(0)} x ${size.height.toStringAsFixed(0)}'),
                Text('Dark Mode: $isDarkMode'),
                Text('Device Pixel Ratio: ${mediaQuery.devicePixelRatio}'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}