import 'package:bingo/features/product/domain/entity/product.dart';

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
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] ?? json['id'],
      shopId: json['shopId'],
      title: json['title'],
      slug: json['slug'],
      images: json['image'],
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
      stock: json['stock'],
      salePrice: (json['sale_price'] as num?)?.toDouble(),
      price: (json['regular_price'] as num?)?.toDouble(),
      warranty: json['warranty'],
      customProperties: json['custom_properties'] as Map<String, dynamic>?,
      cashOnDelivery: json['cashOnDelivery'],
      image: (json['images'] as List<dynamic>?)
          ?.map((e) => Map<String, dynamic>.from(e))
          .toList(),
      quantity: json['quantity'] ?? 1,
    );
  }
  String get firstImageUrl {
    if (image == null || image!.isEmpty) return '';
    final url = image!.first['url'] ?? '';
    if (url.startsWith('http')) return url;
    return 'https://ik.imagekit.io/zeyuss/$url';
  }
}
