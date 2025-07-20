import 'package:bingo/features/profile/domain/entity/product.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.name,
    required super.shortDescription,
    super.brand,
    required super.cashOnDelivery,
    required super.category,
    super.colors,
    super.customProperties,
    super.detailedDesc,
    required super.price,
    required super.salePrice,
    required super.sizes,
    super.slug,
    required super.stock,
    super.subCategory,
    super.tags,
    super.videoURL,
    super.warranty,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] ?? '',
      shortDescription: map['shortDescription'] ?? '',
      cashOnDelivery: map['cashOnDelivery'] ?? false,
      category: map['category'] ?? '',
      price: (map['price'] as num).toDouble(),
      salePrice: (map['salePrice'] as num).toDouble(),
      sizes: List<String>.from(map['sizes'] ?? []),
      stock: map['stock'] ?? 0,
      brand: map['brand'],
      colors: map['colors'] != null ? List<String>.from(map['colors']) : null,
      customProperties: map['customProperties'],
      detailedDesc: map['detailedDesc'],
      slug: map['slug'],
      subCategory: map['subCategory'],
      tags: map['tags'],
      videoURL: map['videoURL'],
      warranty: map['warranty'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'shortDescription': shortDescription,
      'cashOnDelivery': cashOnDelivery,
      'category': category,
      'price': price,
      'salePrice': salePrice,
      'sizes': sizes,
      'stock': stock,
    };

    if (brand != null) data['brand'] = brand;
    if (colors != null) data['colors'] = colors;
    if (customProperties != null) data['customProperties'] = customProperties;
    if (detailedDesc != null) data['detailedDesc'] = detailedDesc;
    if (slug != null) data['slug'] = slug;
    if (subCategory != null) data['subCategory'] = subCategory;
    if (tags != null) data['tags'] = tags;
    if (videoURL != null) data['videoURL'] = videoURL;
    if (warranty != null) data['warranty'] = warranty;

    return data;
  }
}
