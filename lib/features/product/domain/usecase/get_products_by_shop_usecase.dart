import 'package:bingo/features/product/domain/entity/product.dart';
import 'package:bingo/features/product/domain/repo/product_repo.dart';

class GetProductsByShopUsecase {
  final ProductRepo _productRepo;

  GetProductsByShopUsecase(this._productRepo);

  Future<List<ProductEntity>> call(String shopId) async =>
      await _productRepo.getProductsByShopId(shopId);
}
