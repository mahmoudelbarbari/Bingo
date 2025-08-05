import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/product/domain/entity/product.dart';

abstract class ProductRepo {
  Future<List<ProductEntity>> getAllProduct();
  Future<BaseResponse> createProduct(ProductEntity product);
}
