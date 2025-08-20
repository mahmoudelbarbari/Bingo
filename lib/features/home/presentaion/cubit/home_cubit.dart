import 'dart:async';

import 'package:bingo/features/home/domain/usecase/add_to_wishlist_usecase.dart';
import 'package:bingo/features/home/domain/usecase/search_product_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/injection_container.dart';
import '../../../product/domain/entity/product.dart';
import '../../data/models/category_model.dart.dart';
import '../../domain/usecase/clear_wishlist_usecase.dart';
import '../../domain/usecase/get_all_categories_usecase.dart';
import '../../domain/usecase/get_three_prodcut_usecase.dart';
import '../../domain/usecase/get_wishlist_items_usecase.dart';
import '../../domain/usecase/is_in_wishlist_usecase.dart';
import '../../domain/usecase/remove_from_wishlist_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  late GetAllCategoriesUsecase getAllCategoriesUsecase;
  late GetThreeProdcutUsecase getThreeProdcutUsecase;
  late SearchProductUsecase searchProductUsecas;

  //wishlist
  late AddToWishlistUsecase addToWishlistUsecase;
  late GetWishlistItemsUsecase getWishlistItemsUsecase;
  late RemoveFromWishlistUsecase removeFromWishlistUsecase;
  late ClearWishlistUsecase clearWishlistUsecase;
  late IsInWishlistUsecase isInWishlistUsecase;

  List<ProductEntity> _cachedProducts = [];
  CategoryModel? _cachedCategories;
  bool _categoriesLoading = false;

  // Add a map to cache wishlist status
  Map<String, bool> _wishlistStatus = {};
  final Debouncer debouncer = Debouncer(milliseconds: 500);

  HomeCubit() : super(HomeInitial());

  // Expose cached categories for UI fallback
  CategoryModel? get cachedCategories => _cachedCategories;

  Future<void> getCategories() async {
    if (_categoriesLoading) return;
    _categoriesLoading = true;

    getAllCategoriesUsecase = sl();
    try {
      emit(CategoriesLoading());
      _cachedCategories = await getAllCategoriesUsecase.call();
      emit(CategoriesLoaded(_cachedCategories!));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    } finally {
      _categoriesLoading = false;
    }
  }

  Future<void> getThreeProducts() async {
    getThreeProdcutUsecase = sl();
    try {
      emit(ThreeProductsLoading());
      _cachedProducts = await getThreeProdcutUsecase.call();
      emit(ThreeProductsLoaded(_cachedProducts));
    } catch (e) {
      emit(ThreeProductsError(e.toString()));
    }
  }

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    searchProductUsecas = sl();
    try {
      final results = await searchProductUsecas.call(query);
      emit(SearchLoaded(results));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  //wishlist
  Future<void> addToWishlist(String productId) async {
    addToWishlistUsecase = sl();
    try {
      final result = await addToWishlistUsecase.call(productId);
      if (result.status) {
        _wishlistStatus[productId] = true;
        emit(AddToWishlistSuccess(result.message));
      }
    } catch (e) {
      emit(AddToWishListError(e.toString()));
    }
  }

  Future<void> getWishlistItems() async {
    getWishlistItemsUsecase = sl();
    try {
      emit(GetWishlistItemsLoading());
      final products = await getWishlistItemsUsecase.call();
      for (var product in products) {
        if (product.id != null) {
          _wishlistStatus[product.id!] = true;
        }
      }

      emit(GetWishlistItemsSuccess(products));
    } catch (e) {
      emit(GetWishlistItemsError(e.toString()));
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    removeFromWishlistUsecase = sl();
    try {
      emit(RemoveFromWishlistLoading());
      final result = await removeFromWishlistUsecase.call(productId);

      if (result.status) {
        // Update wishlist status cache
        _wishlistStatus[productId] = false;
        emit(RemoveFromWishlistSuccess(result.message));
      } else {
        emit(RemoveFromWishlistError(result.message));
      }
    } catch (e) {
      emit(RemoveFromWishlistError(e.toString()));
    }
  }

  Future<void> clearWishlist() async {
    clearWishlistUsecase = sl();
    try {
      emit(ClearWishlistLoading());
      final result = await clearWishlistUsecase.call();

      if (result.status) {
        // Clear wishlist status cache
        _wishlistStatus.clear();
        emit(ClearWishlistSuccess(result.message));
      } else {
        emit(ClearWishlistError(result.message));
      }
    } catch (e) {
      emit(ClearWishlistError(e.toString()));
    }
  }

  Future<void> checkIfInWishlist(String productId) async {
    // Check cache first
    if (_wishlistStatus.containsKey(productId)) {
      emit(IsInWishlistSuccess(_wishlistStatus[productId]!, productId));
      return;
    }

    isInWishlistUsecase = sl();
    try {
      emit(IsInWishlistLoading());
      final isInWishlist = await isInWishlistUsecase.call(productId);

      // Update cache
      _wishlistStatus[productId] = isInWishlist;

      emit(IsInWishlistSuccess(isInWishlist, productId));
    } catch (e) {
      emit(IsInWishlistError(e.toString()));
    }
  }

  // Helper method to get wishlist status
  bool isProductInWishlist(String productId) {
    return _wishlistStatus[productId] ?? false;
  }
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
