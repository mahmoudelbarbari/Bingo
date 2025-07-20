class ProductEntity {
  final String name;
  final String shortDescription;
  final String? tags;
  final String? warranty;
  final String? slug;
  final String? brand;
  final List<String>? colors;
  final String? customProperties;
  final bool cashOnDelivery;
  final String category;
  final String? subCategory;
  final String? detailedDesc;
  final String? videoURL;
  final double price;
  final double salePrice;
  final int stock;
  final List<String> sizes;

  ProductEntity({
    required this.name,
    required this.shortDescription,
    this.tags,
    this.warranty,
    this.slug,
    this.brand,
    this.colors,
    this.customProperties,
    required this.cashOnDelivery,
    required this.category,
    this.subCategory,
    this.detailedDesc,
    this.videoURL,
    required this.price,
    required this.salePrice,
    required this.stock,
    required this.sizes,
  });
}
