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

// Add these to your home_state.dart file

class SearchLoading extends HomeState {}

class SearchLoaded extends HomeState {
  final List<ProductEntity> products;
  SearchLoaded(this.products);
}

class SearchError extends HomeState {
  final String message;
  SearchError(this.message);
}

class SearchInitial extends HomeState {}

// wishlist state
class WishListLoading extends HomeState {}

class AddToWishListLoading extends HomeState {}

class AddToWishlistSuccess extends HomeState {
  final String message;
  AddToWishlistSuccess(this.message);
}

class AddToWishListError extends HomeState {
  final String message;
  AddToWishListError(this.message);
}

// Get wishlist items states
class GetWishlistItemsLoading extends HomeState {}

class GetWishlistItemsSuccess extends HomeState {
  final List<ProductEntity> products;
  GetWishlistItemsSuccess(this.products);
}

class GetWishlistItemsError extends HomeState {
  final String message;
  GetWishlistItemsError(this.message);
}

// Remove from wishlist states
class RemoveFromWishlistLoading extends HomeState {}

class RemoveFromWishlistSuccess extends HomeState {
  final String message;
  RemoveFromWishlistSuccess(this.message);
}

class RemoveFromWishlistError extends HomeState {
  final String message;
  RemoveFromWishlistError(this.message);
}

// Clear wishlist states
class ClearWishlistLoading extends HomeState {}

class ClearWishlistSuccess extends HomeState {
  final String message;
  ClearWishlistSuccess(this.message);
}

class ClearWishlistError extends HomeState {
  final String message;
  ClearWishlistError(this.message);
}

// Check if in wishlist states
class IsInWishlistLoading extends HomeState {}

class IsInWishlistSuccess extends HomeState {
  final bool isInWishlist;
  final String productId;
  IsInWishlistSuccess(this.isInWishlist, this.productId);
}

class IsInWishlistError extends HomeState {
  final String message;
  IsInWishlistError(this.message);
}
