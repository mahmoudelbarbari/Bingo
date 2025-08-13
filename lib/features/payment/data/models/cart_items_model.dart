// cart_item_model.dart
class CartItemModel {
  final String productId;
  final String title;
  final String image;
  final double price;
  final double salePrice;
  final int quantity;
  final String shopId;
  final Map<String, dynamic>? selectedOptions;

  CartItemModel({
    required this.productId,
    required this.title,
    required this.image,
    required this.price,
    required this.salePrice,
    required this.quantity,
    required this.shopId,
    this.selectedOptions,
  });

  Map<String, dynamic> toJson() => {
    'id': productId,
    'quantity': quantity,
    'sale_price': salePrice,
    'shopId': shopId,
    'selectedOptions': selectedOptions ?? {},
  };
}
