import 'package:flutter/material.dart';

class PageProfil extends StatelessWidget {
  const PageProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
      ),
      body: const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.account_circle, size: 80),
                SizedBox(height: 10),
                Text('Application Flutter', style: TextStyle(fontSize: 20)),
                Text('Gestion d\'étudiants'),
                SizedBox(height: 10),
                Text('TP5 - Navigation & Architecture'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}