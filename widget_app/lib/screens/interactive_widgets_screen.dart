// lib/screens/interactive_widgets_screen.dart
import 'package:flutter/material.dart';

class InteractiveWidgetsScreen extends StatefulWidget {
  const InteractiveWidgetsScreen({super.key});

  @override
  State<InteractiveWidgetsScreen> createState() => _InteractiveWidgetsScreenState();
}

class _InteractiveWidgetsScreenState extends State<InteractiveWidgetsScreen> {
  final TextEditingController _textController = TextEditingController();
  String _gestureLog = 'Tap or long press the colored area';
  bool _isSwitchOn = false;
  double _sliderValue = 0.5;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interactive Widgets')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Buttons'),
            _buildButtonsDemo(),
            const SizedBox(height: 24),
            _buildSectionTitle('GestureDetector'),
            _buildGestureDetectorDemo(),
            const SizedBox(height: 16),
            Text(_gestureLog, style: const TextStyle(fontStyle: FontStyle.italic)),
            const SizedBox(height: 24),
            _buildSectionTitle('TextField & Form'),
            _buildTextFieldDemo(),
            const SizedBox(height: 24),
            _buildSectionTitle('Controls'),
            _buildControlsDemo(),
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

  Widget _buildButtonsDemo() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        ElevatedButton(
          onPressed: () => _showSnackBar(context, 'ElevatedButton pressed'),
          child: const Text('Elevated'),
        ),
        TextButton(
          onPressed: () => _showSnackBar(context, 'TextButton pressed'),
          child: const Text('Text Button'),
        ),
        OutlinedButton(
          onPressed: () => _showSnackBar(context, 'OutlinedButton pressed'),
          child: const Text('Outlined'),
        ),
        IconButton(
          onPressed: () => _showSnackBar(context, 'IconButton pressed'),
          icon: const Icon(Icons.favorite),
        ),
        FilledButton(
          onPressed: () => _showSnackBar(context, 'FilledButton pressed'),
          child: const Text('Filled'),
        ),
      ],
    );
  }

  Widget _buildGestureDetectorDemo() {
    return GestureDetector(
      onTap: () => setState(() => _gestureLog = 'Single tap detected'),
      onDoubleTap: () => setState(() => _gestureLog = 'Double tap detected'),
      onLongPress: () => setState(() => _gestureLog = 'Long press detected'),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.touch_app, size: 48),
              SizedBox(height: 8),
              Text('Tap / Double Tap / Long Press'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldDemo() {
    return Column(
      children: [
        TextField(
          controller: _textController,
          decoration: const InputDecoration(
            labelText: 'Enter text',
            hintText: 'Type something...',
            prefixIcon: Icon(Icons.edit),
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) => _showSnackBar(context, 'Submitted: $value'),
        ),
        const SizedBox(height: 12),
        Form(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'Invalid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => _showSnackBar(context, 'Form submitted'),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildControlsDemo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Switch(
              value: _isSwitchOn,
              onChanged: (value) => setState(() => _isSwitchOn = value),
            ),
            Text(_isSwitchOn ? 'ON' : 'OFF'),
          ],
        ),
        Column(
          children: [
            SizedBox(
              width: 200,
              child: Slider(
                value: _sliderValue,
                onChanged: (value) => setState(() => _sliderValue = value),
              ),
            ),
            Text('Value: ${_sliderValue.toStringAsFixed(2)}'),
          ],
        ),
        Checkbox(
          value: false,
          onChanged: (value) => _showSnackBar(context, 'Checkbox toggled'),
        ),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(milliseconds: 800)),
    );
  }
}