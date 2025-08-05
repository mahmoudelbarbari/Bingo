import 'package:bingo/features/product/data/models/product_model.dart';

import '../../../../core/util/base_response.dart';

abstract class CartReporisatoryInterface {
  Future<BaseResponse> addProductToCart(ProductModel productModel);
  Future<List<ProductModel>> getAllCartItems();
  Future<List<ProductModel>> viewOrders();
  Future<BaseResponse> clearCartItems();
  Future<BaseResponse> deleteItemByID(String id);
}
