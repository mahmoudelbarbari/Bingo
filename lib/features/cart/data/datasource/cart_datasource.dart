import 'package:bingo/features/profile/data/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/util/base_response.dart';
import '../models/cart_items_model.dart';

class FirebaseDatasourceProvider {
  static final _firebaseDatasourceProvider =
      FirebaseDatasourceProvider._internal();

  factory FirebaseDatasourceProvider() {
    return _firebaseDatasourceProvider;
  }

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseDatasourceProvider._internal();
}

abstract class CartDatasourceInterface extends FirebaseDatasourceProvider {
  CartDatasourceInterface() : super._internal();

  Future<BaseResponse> addProductToCart(ProductModel productModel);
  Future<BaseResponse> addCartData(CartItemModel cartItemModel);
  Future<List<ProductModel>> getAllCartItems();
  Future<List<ProductModel>> viewwOrder();
  Future<BaseResponse> clearCartItems();
  Future<BaseResponse> deleteItemById(String id);
}

class CartDatasourceImpl extends CartDatasourceInterface {
  CartDatasourceImpl() : super();

  @override
  Future<BaseResponse> addProductToCart(ProductModel productModel) async {
    try {
      await firebaseFirestore.collection('cart').doc().set({
        'name': productModel.name,
        'price': productModel.price,
        'shortDescription': productModel.shortDescription,
      });
      await firebaseFirestore.collection('order_save').doc().set({
        'name': productModel.name,
        'price': productModel.price,
        'shortDescription': productModel.shortDescription,
      });
      return BaseResponse(
        status: true,
        message: "Item added , ${productModel.name} was added to your cart",
      );
    } catch (e) {
      return BaseResponse(status: false, message: e.toString());
    }
  }

  @override
  Future<BaseResponse> addCartData(CartItemModel cartItemModel) async {
    try {
      await firebaseFirestore.collection("checkout_list").doc().set({
        'name': cartItemModel.name,
        'price': cartItemModel.price,
        'quantity': cartItemModel.quantity,
      });
      return BaseResponse(
        status: true,
        message: "Item added , ${cartItemModel.name} to checkout list",
      );
    } catch (e) {
      return BaseResponse(status: false, message: e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getAllCartItems() async {
    final retrive = firebaseFirestore.collection('cart');
    final querySnapshot = await retrive.get();
    querySnapshot.docs.map((e) => e.data()).toList();
    List<ProductModel> cartItems = [];
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in querySnapshot.docs) {
      cartItems.add(ProductModel.fromSnapShot(doc));
    }
    return cartItems;
  }

  @override
  Future<List<ProductModel>> viewwOrder() async {
    final retrive = firebaseFirestore.collection('order_save');
    final querySnapshot = await retrive.get();
    querySnapshot.docs.map((e) => e.data()).toList();
    List<ProductModel> cartItems = [];
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in querySnapshot.docs) {
      cartItems.add(ProductModel.fromSnapShot(doc));
    }
    return cartItems;
  }

  @override
  Future<BaseResponse> clearCartItems() async {
    try {
      firebaseFirestore.collection('cart').get().then((snapshot) {
        for (DocumentSnapshot documents in snapshot.docs) {
          documents.reference.delete();
        }
      });
      return BaseResponse(status: true, message: "Cart cleared Successfully");
    } catch (e) {
      return BaseResponse(status: false, message: e.toString());
    }
  }

  @override
  Future<BaseResponse> deleteItemById(String id) async {
    try {
      final cartQuery = await firebaseFirestore
          .collection('cart')
          .where('name', isEqualTo: id)
          .get();

      final orderQuery = await firebaseFirestore
          .collection('order_save')
          .where('name', isEqualTo: id)
          .get();

      // Delete matching documents
      for (var doc in cartQuery.docs) {
        await doc.reference.delete();
      }

      for (var doc in orderQuery.docs) {
        await doc.reference.delete();
      }

      if (cartQuery.docs.isEmpty) {
        return BaseResponse(status: false, message: 'Item not found in cart');
      }

      return BaseResponse(status: true, message: 'Item deleted successfully');
    } catch (e) {
      if (kDebugMode) {
        print('Delete error: ${e.toString()}');
      } // Debug print
      return BaseResponse(
        status: false,
        message: 'Failed to delete item: ${e.toString()}',
      );
    }
  }
}
