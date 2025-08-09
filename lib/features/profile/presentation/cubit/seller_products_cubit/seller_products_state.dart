import 'package:bingo/features/product/domain/entity/product.dart';

abstract class SellerProductsState {}

class SellerProductsInitialState extends SellerProductsState {}

class SellerProductsLoadingState extends SellerProductsState {}

class SellerProductsLoadedState extends SellerProductsState {
  final List<ProductEntity> products;

  SellerProductsLoadedState({required this.products});
}

class SellerProductsErrorState extends SellerProductsState {
  final String errorMessage;

  SellerProductsErrorState({required this.errorMessage});
}
