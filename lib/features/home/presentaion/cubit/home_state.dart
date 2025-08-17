import 'package:bingo/features/home/data/models/category_model.dart.dart';
import 'package:bingo/features/product/domain/entity/product.dart';

abstract class HomeState {}

class CategoriesLoading extends HomeState {}

class CategoriesLoaded extends HomeState {
  final CategoryModel categories;
  CategoriesLoaded(this.categories);
}

class CategoriesError extends HomeState {
  final String message;
  CategoriesError(this.message);
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class ThreeProductsLoading extends HomeState {}

class ThreeProductsLoaded extends HomeState {
  final List<ProductEntity> products;
  ThreeProductsLoaded(this.products);
}

class ThreeProductsError extends HomeState {
  final String message;
  ThreeProductsError(this.message);
}

class CombinedState extends HomeState {
  final List<ProductEntity> products;
  final CategoryModel? categories;

  CombinedState({required this.products, this.categories});
}
