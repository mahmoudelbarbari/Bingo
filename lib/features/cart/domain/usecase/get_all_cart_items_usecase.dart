import 'package:bingo/features/product/data/models/product_model.dart';

import '../reporisatory/cart_reporisatory.dart';

class GetAllCartItemsUsecase {
  final CartReporisatoryInterface cartReporisatoryInterface;
  GetAllCartItemsUsecase(this.cartReporisatoryInterface);

  Future<List<ProductModel>> call() async {
    return await cartReporisatoryInterface.getAllCartItems();
  }
}
