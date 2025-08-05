import 'package:bingo/features/cart/domain/reporisatory/cart_reporisatory.dart';
import 'package:bingo/features/product/data/models/product_model.dart';

import '../../../../core/util/base_response.dart';

class AddProductToCartUsecase {
  final CartReporisatoryInterface cartReporisatoryInterface;
  AddProductToCartUsecase(this.cartReporisatoryInterface);

  Future<BaseResponse> call(ProductModel productModel) async {
    return await cartReporisatoryInterface.addProductToCart(productModel);
  }
}
