import '../../domain/entities/product.dart';

class ProductProfileModel extends Product {
  ProductProfileModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.description,
    required super.price,
    super.discountedPrice,
    required super.isFavorite,
    required super.rating,
    required super.oldPrice,
  });

  factory ProductProfileModel.fromMap(Map<String, dynamic> map) {
    // Extract the first image URL from the images array
    String imageUrl = '';
    if (map['images'] != null &&
        map['images'] is List &&
        (map['images'] as List).isNotEmpty) {
      final firstImage = map['images'][0];
      if (firstImage is Map && firstImage['url'] != null) {
        imageUrl = firstImage['url'];
      }
    }

    print('🔍 Mapping product: ${map['title']}');
    print('🔍 Image URL: $imageUrl');
    print('🔍 Sale price: ${map['sale_price']}');
    print('🔍 Regular price: ${map['regular_price']}');

    return ProductProfileModel(
      id: map['id'] ?? '',
      name: map['title'] ?? '', // API has 'title'
      imageUrl: imageUrl, // Extract from images array
      description:
          map['short_description'] ?? '', // API has 'short_description'
      price: (map['sale_price'] ?? 0).toDouble(), // API has 'sale_price'
      discountedPrice: map['sale_price'] != null
          ? (map['sale_price']).toDouble()
          : null,
      isFavorite: map['isFavorite'] ?? false,
      rating: map['ratings']?.toDouble() ?? 4.5, // API has 'ratings'
      oldPrice: map['regular_price'] != null
          ? (map['regular_price']).toDouble()
          : 0.0, // API has 'regular_price'
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': name,
      'short_description': description,
      'sale_price': price,
      'discountedPrice': discountedPrice,
      'isFavorite': isFavorite,
      'ratings': rating,
      "regular_price": oldPrice,
    };
  }
}
