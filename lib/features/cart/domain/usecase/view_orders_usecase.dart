import 'package:bingo/features/cart/domain/reporisatory/cart_reporisatory.dart';
import 'package:bingo/features/product/data/models/product_model.dart';

class ViewOrderUsecase {
  final CartReporisatoryInterface cartReporisatoryInterface;
  ViewOrderUsecase(this.cartReporisatoryInterface);

  Future<List<ProductModel>> call() async {
    return await cartReporisatoryInterface.viewOrders();
  }
}
