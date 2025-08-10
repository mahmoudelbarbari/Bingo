
import '../../domain/entities/seller_profile.dart';

class SellerProfileModel extends SellerProfile {
  SellerProfileModel({
    required super.name,
    required super.imageUrl,
    required super.bio,
    required super.isVerified,
  });

  factory SellerProfileModel.fromMap(Map<String, dynamic> map) {
    return SellerProfileModel(
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      bio: map['bio'] ?? '',
      isVerified: map['isVerified'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'bio': bio,
      'isVerified': isVerified,
    };
  }
}
