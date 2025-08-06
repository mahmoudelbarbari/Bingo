import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/product/domain/repo/product_repo.dart';

import '../../data/models/product_model.dart';

class AddProductUsecase {
  final ProductRepo _productRepo;

  AddProductUsecase(this._productRepo);

  Future<BaseResponse> call(ProductModel product) async =>
      await _productRepo.createProduct(product);
}
