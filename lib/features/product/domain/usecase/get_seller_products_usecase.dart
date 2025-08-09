import 'package:bingo/core/helper/token_storage.dart';
import 'package:bingo/features/product/domain/entity/product.dart';
import 'package:bingo/features/product/domain/repo/product_repo.dart';

class GetSellerProductsUsecase {
  final ProductRepo _productRepo;

  GetSellerProductsUsecase(this._productRepo);

  Future<List<ProductEntity>> call() async {
    // Get the current seller's shopId
    final shopId = await TokenStorage.getShopId();

    if (shopId == null || shopId.isEmpty) {
      throw Exception('No shop found for current seller');
    }

    return await _productRepo.getProductsByShopId(shopId);
  }
}
