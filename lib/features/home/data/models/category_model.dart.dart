class CategoryModel {
  final String id;
  final List<String> categories;
  final Map<String, List<String>> subCategories;

  CategoryModel({
    required this.id,
    required this.categories,
    required this.subCategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] ?? '',
      categories: List<String>.from(json['categories'] ?? []),
      subCategories: Map<String, List<String>>.from(
        json['subCategories']?.map(
              (key, value) => MapEntry(key, List<String>.from(value)),
            ) ??
            {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'categories': categories,
      'subCategories': subCategories,
    };
  }
}
