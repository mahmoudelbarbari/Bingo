import 'package:bingo/features/payment/data/models/cart_items_model.dart';
import 'package:bingo/features/product/data/models/product_model.dart';

abstract class CartState {}

class CartStateInt extends CartState {}

class CartLoading extends CartState {}

class CartError extends CartState {
  String errorMessage;
  CartError({required this.errorMessage});
}

class CartSuccess extends CartState {
  CartSuccess(addedCartItem);
}

class CartItemsLoadded extends CartState {
  final List<ProductModel> prodcutModel;
  CartItemsLoadded({required this.prodcutModel});
}

class CartClearedSuccessfully extends CartState {
  CartClearedSuccessfully(clearedCart);
}

class EmptyCart extends CartState {}

class ItemDeletedSuccess extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemModel> cartItems;

  CartLoaded(this.cartItems);
}
