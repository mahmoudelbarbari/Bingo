import 'package:bingo/features/shops/domain/entity/shop_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopModel extends ShopEntity {
  ShopModel({
    super.id,
    super.name,
    super.bio,
    super.category,
    super.image,
    super.openingHours,
    super.rating,
    super.sellerId,
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'image': image,
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
      image: map['image'],
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
    image: shopEntity.image,
    name: shopEntity.name,
    bio: shopEntity.bio,
    category: shopEntity.category,
    openingHours: shopEntity.openingHours,
    rating: shopEntity.rating,
    sellerId: shopEntity.sellerId,
  );
}
