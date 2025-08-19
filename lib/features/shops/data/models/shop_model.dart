import 'package:bingo/features/shops/domain/entity/shop_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../product/data/models/product_model.dart';

class ShopModel extends ShopEntity {
  ShopModel({
    super.id,
    super.name,
    super.address,
    super.bio,
    super.category,
    super.openingHours,
    super.rating,
    super.sellerId,
    super.avatarUrl,
    super.products,
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'bio': bio,
      'category': category,
      'opening_hours': openingHours,
      'ratings': rating,
      'sellerId': sellerId,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  // Create from Map
  factory ShopModel.fromMap(Map<String, dynamic> map, String id) {
    return ShopModel(
      id: id,
      name: map['name'],
      bio: map['bio'],
      category: List<String>.from(map['category'] ?? []),
      openingHours: map['opening_hours'],
      rating: (map['ratings'] as num?)?.toDouble(),
      sellerId: map['sellerId'],
      avatarUrl: map['url'],
      products:
          (map['products'] as List<dynamic>?)
              ?.map((p) => p is ProductModel ? p : ProductModel.fromJson(p))
              .toList() ??
          [],
      address: map['address'],
    );
  }

  factory ShopModel.fromJson(Map<String, dynamic> map) {
    return ShopModel(
      id: map['id'],
      name: map['name'],
      bio: map['bio'],
      address: map['address'],
      avatarUrl: _getAvatarUrl(map),
      category: List<String>.from(map['category'] ?? []),
      openingHours: map['opening_hours'],
      rating: (map['ratings'] as num?)?.toDouble(),
      sellerId: map['sellerId'],
      products:
          (map['products'] as List<dynamic>?)
              ?.map((p) => p is ProductModel ? p : ProductModel.fromJson(p))
              .toList() ??
          [],
    );
  }

  //shop model from shop entity
  factory ShopModel.fromEntity(ShopEntity shopEntity) => ShopModel(
    id: shopEntity.id,
    name: shopEntity.name,
    address: shopEntity.address,
    bio: shopEntity.bio,
    category: shopEntity.category,
    openingHours: shopEntity.openingHours,
    rating: shopEntity.rating,
    sellerId: shopEntity.sellerId,
    avatarUrl: shopEntity.avatarUrl,
    products: shopEntity.products,
  );

  static String? _getAvatarUrl(Map<String, dynamic> json) {
    // First try to get from avatar object
    if (json['avatar'] is Map && json['avatar']['url'] != null) {
      return json['avatar']['url'];
    }
    // Then try avatarId if you can construct URL from it
    if (json['avatarId'] != null) {
      return 'https://ik.imagekit.io/zeyuss/avatars/${json['avatarId']}';
    }
    // Default to null if no avatar available
    return null;
  }
}
