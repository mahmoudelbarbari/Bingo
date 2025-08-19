import 'package:bingo/features/product/domain/entity/product.dart';

import '../../../shops/data/models/shop_model.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    super.id,
    super.title,
    super.shortDescription,
    super.brand,
    super.cashOnDelivery,
    super.category,
    super.colors,
    super.customProperties,
    super.detailedDesc,
    super.price,
    super.salePrice,
    super.sizes,
    super.slug,
    super.stock,
    super.subCategory,
    super.tags,
    super.videoURL,
    super.warranty,
    super.image,
    super.shopId,
    super.images,
    super.quantity,
    super.shop,
    super.ratings,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'slug': slug,
      'category': category,
      'subCategory': subCategory,
      'short_description': shortDescription,
      'detailed_description': detailedDesc,
      'images': image, // This should be 'images' not 'image'
      'video_url': videoURL,
      'tags': tags,
      'brand': brand,
      'colors': colors,
      'sizes': sizes,
      'stock': stock,
      'sale_price': salePrice,
      'regular_price': price,
      'warranty': warranty,
      'custom_properties': customProperties,
      'cashOnDelivery': cashOnDelivery,
      'shopId': shopId, // required for relation
      'ratings': ratings,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] ?? json['id'],
      shopId: json['shopId'],
      title: json['title'],
      slug: json['slug'],
      category: json['category'],
      subCategory: json['subCategory'],
      shortDescription: json['short_description'],
      detailedDesc: json['detailed_description'],
      videoURL: json['video_url'],
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      brand: json['brand'],
      colors: (json['colors'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      sizes: (json['sizes'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      stock: _parseIntField(json['stock']),
      salePrice: _parseDoubleField(json['sale_price']),
      price: _parseDoubleField(json['regular_price']),
      warranty: json['warranty']?.toString(),
      customProperties: _parseCustomProperties(json['custom_properties']),
      cashOnDelivery: json['cashOnDelivery'],
      image: _parseImages(json['images']),
      quantity: _parseIntField(json['quantity']) ?? 1,
      shop: json['Shop'] is Map<String, dynamic> ? json['Shop'] : null,
      ratings: _parseIntField(json['ratings']),
    );
  }

  static Map<String, dynamic>? _parseCustomProperties(dynamic customProps) {
    if (customProps == null) return null;
    if (customProps is Map<String, dynamic>) return customProps;
    if (customProps is List) {
      // Convert List to Map - you can customize this logic based on your needs
      Map<String, dynamic> result = {};
      for (int i = 0; i < customProps.length; i++) {
        if (customProps[i] is Map<String, dynamic>) {
          final prop = customProps[i] as Map<String, dynamic>;
          if (prop.containsKey('label') && prop.containsKey('values')) {
            result[prop['label']] = prop['values'];
          }
        }
      }
      return result.isEmpty ? null : result;
    }
    return null;
  }

  static List<Map<String, dynamic>>? _parseImages(dynamic images) {
    if (images == null) return null;
    if (images is List<dynamic>) {
      return images
          .where((e) => e is Map<String, dynamic>)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }
    return null;
  }

  static int? _parseIntField(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    if (value is num) return value.toInt();
    return null;
  }

  static double? _parseDoubleField(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    if (value is num) return value.toDouble();
    return null;
  }
  ShopModel? get shopModel {
    if (shop == null) return null;
    return ShopModel.fromJson(shop!);
  }

  String get firstImageUrl {
    if (image == null || image!.isEmpty) return '';
    final url = image!.first['url'] ?? '';
    if (url.startsWith('http')) return url;
    return 'https://ik.imagekit.io/zeyuss/$url';
  }
}
