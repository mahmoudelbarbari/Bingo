class ProductEntity {
  final String? id;
  final String? shopId;
  final String? title;
  final String? shortDescription;
  final List<String>? tags;
  final String? warranty;
  final String? slug;
  final String? brand;
  final List<String>? colors;
  final Map<String, dynamic>? customProperties;
  final String? cashOnDelivery;
  final String? category;
  final String? subCategory;
  final String? detailedDesc;
  final String? videoURL;
  final double? price;
  final double? salePrice;
  final int? stock;
  final List<String>? sizes;
  final List<Map<String, dynamic>>? image;

  ProductEntity({
    this.id,
    this.shopId,
    this.title,
    this.shortDescription,
    this.tags,
    this.warranty,
    this.slug,
    this.brand,
    this.colors,
    this.customProperties,
    this.cashOnDelivery,
    this.category,
    this.subCategory,
    this.detailedDesc,
    this.videoURL,
    this.price,
    this.salePrice,
    this.stock,
    this.sizes,
    this.image,
  });
}
