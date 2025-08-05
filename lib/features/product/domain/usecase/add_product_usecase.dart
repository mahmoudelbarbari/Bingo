import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/product/domain/entity/product.dart';
import 'package:bingo/features/product/domain/repo/product_repo.dart';

class AddProductUsecase {
  final ProductRepo _productRepo;

  AddProductUsecase(this._productRepo);

  Future<BaseResponse> call(ProductEntity product) async =>
      await _productRepo.createProduct(product);
}
