import 'package:bingo/features/profile/domain/entity/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    super.name,
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

  factory ProductModel.fromSnapShot(
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot,
  ) {
    final map = documentSnapshot.data()!;
    return ProductModel(
      name: map['name'] ?? '',
      shortDescription: map['shortDescription'] ?? '',
      image: map['image'] ?? '',
      cashOnDelivery: map['cashOnDelivery'] ?? false,
      category: map['category'] ?? '',
      price: map['price'] != null ? (map['price'] as num).toDouble() : 0.0,
      salePrice: map['salePrice'] != null
          ? (map['salePrice'] as num).toDouble()
          : 0.0,
      sizes: List<String>.from(map['sizes'] ?? []),
      stock: map['stock'] ?? 0,
      brand: map['brand'] ?? '',
      colors: map['colors'] != null ? List<String>.from(map['colors']) : null,
      customProperties: map['customProperties'] ?? '',
      detailedDesc: map['detailedDesc'] ?? '',
      slug: map['slug'] ?? "",
      subCategory: map['subCategory'] ?? '',
      tags: map['tags'] ?? '',
      videoURL: map['videoURL'] ?? '',
      warranty: map['warranty'] ?? '',
    );
  }
}
