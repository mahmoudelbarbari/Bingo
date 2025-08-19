import 'package:bingo/features/product/domain/entity/product.dart';

class ShopEntity {
  final String? id;
  final String? name;
  final String? address;
  final String? avatarUrl;
  final String? bio;
  final List<String>? category;
  final String? openingHours;
  final int? rating;
  final String? sellerId;
  final List<ProductEntity>? products;

  ShopEntity({
    this.id,
    this.name,
    this.address,
    this.bio,
    this.category,
    this.openingHours,
    this.rating,
    this.sellerId,
    this.avatarUrl,
    this.products,
  });
}
