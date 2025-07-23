import 'package:bingo/features/cart/data/datasource/cart_datasource.dart';
import 'package:bingo/features/cart/domain/reporisatory/cart_reporisatory.dart';
import 'package:bingo/features/profile/data/model/product_model.dart';

import '../../../../core/util/base_response.dart';

class CartReporisatoryImpl implements CartReporisatoryInterface {
  final CartDatasourceInterface cartDatasourceInterface;
  CartReporisatoryImpl(this.cartDatasourceInterface);

  @override
  Future<BaseResponse> addProductToCart(ProductModel productModel) async {
    return await cartDatasourceInterface.addProductToCart(productModel);
  }

  @override
  Future<List<ProductModel>> getAllCartItems() async {
    return await cartDatasourceInterface.getAllCartItems();
  }

  @override
  Future<List<ProductModel>> viewOrders() async {
    return await cartDatasourceInterface.viewwOrder();
  }

  @override
  Future<BaseResponse> clearCartItems() async {
    return await cartDatasourceInterface.clearCartItems();
  }
}
