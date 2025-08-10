class Product {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final double price;
  final double? oldPrice;
  final double rating;
  final double? discountedPrice;
  final bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    this.discountedPrice,
    this.oldPrice,
    required this.rating,
    required this.isFavorite,
  });
}
