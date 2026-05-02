import 'package:flutter/material.dart';


class ListsPage extends StatelessWidget {
  const ListsPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text('This is the lists page'),
      ),
    );
  }
}