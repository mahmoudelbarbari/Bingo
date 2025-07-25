import 'package:bingo/features/cart/domain/usecase/delete_item_by_id_usecase.dart';
import 'package:bingo/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/injection_container.dart';
import '../../../profile/data/model/product_model.dart';
import '../../domain/usecase/add_items_to_cart_usecase.dart';
import '../../domain/usecase/clear_cart_items_usecase.dart';
import '../../domain/usecase/get_all_cart_items_usecase.dart';
import '../../domain/usecase/view_orders_usecase.dart';

class CartCubit extends Cubit<CartState> {
  late AddProductToCartUsecase addProductToCartUsecase;
  late GetAllCartItemsUsecase getAllCartItemsUsecase;
  late ViewOrderUsecase viewOrderUsecase;
  late ClearCartItemsUsecase clearCartItemsUsecase;
  late DeleteItemByIdUsecase deleteItemByIdUsecase;

  CartCubit() : super(CartLoading());

  Future<void> addProductToCart(ProductModel productModel) async {
    try {
      addProductToCartUsecase = sl();
      final addedCartItem = await addProductToCartUsecase.call(productModel);
      if (addedCartItem.status) {
        emit(CartSuccess(addedCartItem));
      } else {
        emit(CartError(errorMessage: addedCartItem.message));
      }
    } catch (e) {
      emit(CartError(errorMessage: e.toString()));
    }
  }

  Future<void> getAllCartItems() async {
    try {
      emit(CartLoading());
      getAllCartItemsUsecase = sl();
      final allCartItems = await getAllCartItemsUsecase.call();
      if (allCartItems.isEmpty) {
        emit(EmptyCart());
      } else {
        emit(CartItemsLoadded(prodcutModel: allCartItems));
      }
    } catch (e) {
      emit(CartError(errorMessage: e.toString()));
    }
  }

  Future<void> viewOrder() async {
    try {
      emit(CartLoading());
      viewOrderUsecase = sl();
      final getAllOrders = await viewOrderUsecase.call();
      emit(CartItemsLoadded(prodcutModel: getAllOrders));
    } catch (e) {
      emit(CartError(errorMessage: e.toString()));
    }
  }

  Future<void> clearCartItems() async {
    try {
      emit(CartLoading());
      clearCartItemsUsecase = sl();
      final clearedCart = await clearCartItemsUsecase.call();
      if (clearedCart.status) {
        emit(CartClearedSuccessfully(clearedCart));
      } else {
        emit(CartError(errorMessage: clearedCart.message));
      }
    } catch (e) {
      emit(CartError(errorMessage: e.toString()));
    }
  }

  Future<void> deleteItemById(String id) async {
    try {
      deleteItemByIdUsecase = sl();
      final deletedItem = await deleteItemByIdUsecase.call(id);
      if (deletedItem.status) {
        emit(ItemDeletedSuccess());
        await getAllCartItems();
      } else {
        emit(CartError(errorMessage: 'There is a problem'));
      }
    } catch (e) {
      emit(CartError(errorMessage: e.toString()));
    }
  }
}
