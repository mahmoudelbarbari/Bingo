import 'package:bingo/features/dashboard/domain/entity/discount_code_entity.dart';

class DiscountCodeModel extends DiscountCodeEntity {
  DiscountCodeModel({
    super.id,
    super.publicName,
    super.discountType,
    super.discountValue,
    super.discountCode,
    super.sellerId,
  });

  factory DiscountCodeModel.fromJson(Map<String, dynamic> json) {
    return DiscountCodeModel(
      id: json['id'],
      publicName: json['public_name'],
      discountType: json['discountType'],
      discountValue: json['discountValue'],
      discountCode: json['discountCode'],
      sellerId: json['sellerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'public_name': publicName,
      'discountType': discountType,
      'discountValue': discountValue,
      'discountCode': discountCode,
      'sellerId': sellerId,
    };
  }

  factory DiscountCodeModel.fromEntity(DiscountCodeEntity entity) {
    return DiscountCodeModel(
      id: entity.id,
      publicName: entity.publicName,
      discountType: entity.discountType,
      discountValue: entity.discountValue,
      discountCode: entity.discountCode,
      sellerId: entity.sellerId,
    );
  }
}
