import 'package:bingo/features/product/domain/entity/product.dart';
import 'package:bingo/features/product/domain/repo/product_repo.dart';

class GetProductsUsecase {
  final ProductRepo _productRepo;

  GetProductsUsecase(this._productRepo);

  Future<List<ProductEntity>> call() async =>
      await _productRepo.getAllProduct();
}
