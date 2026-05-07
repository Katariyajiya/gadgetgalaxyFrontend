class Product {
  final int id;
  final String name;
  final String brand;
  final String category;
  final double price;
  final double oldPrice;
  final double rating;
  final int reviews;
  final String emoji;
  final String? badge;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.reviews,
    required this.emoji,
    this.badge,
  });
}