import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_detail_page.dart';
import 'add_product_page.dart';

class ProductListViewPage extends StatefulWidget {
  const ProductListViewPage({super.key});

  @override
  State<ProductListViewPage> createState() => _ProductListViewPageState();
}

class _ProductListViewPageState extends State<ProductListViewPage> {
  // Liste des produits (état local à la page)
  final List<Product> _products = [
    Product(id: '1', nom: 'MacBook Pro', prix: 2499.99),
    Product(id: '2', nom: 'iPhone 15', prix: 1099.99),
    Product(id: '3', nom: 'AirPods Pro', prix: 299.99),
    Product(id: '4', nom: 'iPad Air', prix: 699.99),
    Product(id: '5', nom: 'Apple Watch', prix: 449.99),
  ];

  void _ajouterProduit(Product nouveauProduit) {
    setState(() {
      _products.add(nouveauProduit);
    });
  }

  void _supprimerProduit(String id) {
    setState(() {
      _products.removeWhere((product) => product.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des produits'),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: _products.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Aucun produit',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Text(
                    'Appuyez sur le bouton + pour en ajouter',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  elevation: 2,
                  child: ListTile(
                    title: Text(
                      product.nom,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text('${product.prix.toStringAsFixed(2)} €'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _confirmerSuppression(context, product.id),
                      tooltip: 'Supprimer',
                    ),
                    // Navigation vers la page de détail
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(product: product),
                        settings: RouteSettings(name: '/detail/${product.id}'),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _naviguerVersAjout(context),
        child: const Icon(Icons.add),
        tooltip: 'Ajouter un produit',
      ),
    );
  }



  void _naviguerVersAjout(BuildContext context) async {
    // Navigation avec retour potentiel de données
    final nouveauProduit = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddProductPage(),
        settings: const RouteSettings(name: '/ajout'),
      ),
    );

    if (nouveauProduit != null && nouveauProduit is Product) {
      _ajouterProduit(nouveauProduit);
      // Afficher un snackbar de confirmation
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${nouveauProduit.nom} ajouté avec succès'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _confirmerSuppression(BuildContext context, String productId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Voulez-vous vraiment supprimer ce produit ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _supprimerProduit(productId);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Produit supprimé'),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            },
            child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}