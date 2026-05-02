import 'package:flutter/material.dart';
import '../models/product.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prixController = TextEditingController();

  @override
  void dispose() {
    _nomController.dispose();
    _prixController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un produit'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Champ Nom
                      TextFormField(
                        controller: _nomController,
                        decoration: const InputDecoration(
                          labelText: 'Nom du produit',
                          prefixIcon: Icon(Icons.label),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Veuillez saisir un nom';
                          }
                          if (value.length < 2) {
                            return 'Nom trop court (min 2 caractères)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Champ Prix
                      TextFormField(
                        controller: _prixController,
                        decoration: const InputDecoration(
                          labelText: 'Prix (€)',
                          prefixIcon: Icon(Icons.euro),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Veuillez saisir un prix';
                          }
                          final prix = double.tryParse(value.replaceAll(',', '.'));
                          if (prix == null) {
                            return 'Prix invalide';
                          }
                          if (prix <= 0) {
                            return 'Le prix doit être positif';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Boutons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context); // Retour sans ajout
                      },
                      icon: const Icon(Icons.cancel),
                      label: const Text('Annuler'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _ajouterProduit,
                      icon: const Icon(Icons.check),
                      label: const Text('Ajouter'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _ajouterProduit() {
    if (_formKey.currentState!.validate()) {
      final nom = _nomController.text.trim();
      final prix = double.parse(_prixController.text.replaceAll(',', '.'));

      final nouveauProduit = Product(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        nom: nom,
        prix: prix,
      );

      // Retourner le nouveau produit vers la page précédente
      Navigator.pop(context, nouveauProduit);
    }
  }
}