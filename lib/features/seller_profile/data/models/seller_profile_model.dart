import '../../domain/entities/seller_profile.dart';

class SellerProfileModel extends SellerProfile {
  SellerProfileModel({
    required super.name,
    required super.imageUrl,
    required super.bio,
    required super.isVerified,
    required super.coverBanner,
  });

  factory SellerProfileModel.fromMap(Map<String, dynamic> map) {
    final shop = (map['shop'] ?? {}) as Map<String, dynamic>;

    return SellerProfileModel(
      imageUrl: shop['avatar'] as String? ?? '',
      coverBanner: shop['coverBanner'] as String? ?? '',
      name: shop['name'] as String? ?? '',
      bio: shop['bio'] as String? ?? '',
      isVerified: shop['isVerified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'avatar': imageUrl,
      'coverBanner': coverBanner,
      'bio': bio,
      'isVerified': isVerified,
    };
  }
}
