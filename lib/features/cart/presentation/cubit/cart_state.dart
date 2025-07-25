import 'package:bingo/features/profile/data/model/product_model.dart';

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
