import 'package:bingo/features/shops/domain/entity/shop_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'bio': bio,
      'category': category,
      'openingHours': openingHours,
      'rating': rating,
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
      openingHours: map['openingHours'],
      rating: map['rating'],
      sellerId: map['sellerId'],
    );
  }

  factory ShopModel.fromJson(Map<String, dynamic> map) {
    return ShopModel(
      id: map['id'],
      name: map['name'],
      bio: map['bio'],
      category: List<String>.from(map['category'] ?? []),
      openingHours: map['openingHours'],
      rating: map['rating'],
      sellerId: map['sellerId'],
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
  );
}
