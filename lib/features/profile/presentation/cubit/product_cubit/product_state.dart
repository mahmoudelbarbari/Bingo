import 'package:bingo/features/profile/domain/entity/product.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<ProductEntity> productEntity;
  ProductLoadedState({required this.productEntity});
}

class ProductErrorState extends ProductState {
  ProductErrorState({required this.errorMessage});
  String errorMessage;
}
