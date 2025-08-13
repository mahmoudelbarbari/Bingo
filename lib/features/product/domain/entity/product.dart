class ProductEntity {
  final String? id;
  final String? images;
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
  final int quantity;

  ProductEntity({
    this.id,
    this.shopId,
    this.images,
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
    this.quantity = 1,
  });

  String get firstImageUrl {
    if (image == null || image!.isEmpty) return '';
    final url = image!.first['url'] ?? '';
    if (url.startsWith('http')) return url;
    return 'https://ik.imagekit.io/zeyuss/$url';
  }
}
