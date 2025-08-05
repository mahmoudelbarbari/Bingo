import 'package:bingo/features/product/data/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  Future<BaseResponse> addCartData(CartItemModel cartItemModel) {
    // TODO: implement addCartData
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse> addProductToCart(ProductModel productModel) {
    // TODO: implement addProductToCart
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse> clearCartItems() {
    // TODO: implement clearCartItems
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse> deleteItemById(String id) {
    // TODO: implement deleteItemById
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getAllCartItems() {
    // TODO: implement getAllCartItems
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> viewwOrder() {
    // TODO: implement viewwOrder
    throw UnimplementedError();
  }
}
