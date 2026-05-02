class Product {
  final String id;
  final String nom;
  final double prix;

  Product({
    required this.id,
    required this.nom,
    required this.prix,
  });

  // Pour faciliter la création de produits d'exemple
  factory Product.exemple({required String nom, required double prix}) {
    return Product(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nom: nom,
      prix: prix,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, nom: $nom, prix: $prix €)';
  }
}