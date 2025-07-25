class ProductEntity {
  final String? id;
  final String? name;
  final String? shortDescription;
  final String? tags;
  final String? warranty;
  final String? slug;
  final String? brand;
  final List<String>? colors;
  final String? customProperties;
  final bool? cashOnDelivery;
  final String? category;
  final String? subCategory;
  final String? detailedDesc;
  final String? videoURL;
  final double? price;
  final double? salePrice;
  final int? stock;
  final List<String>? sizes;
  final String? image;
  ProductEntity({
    this.id,
    this.name,
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
