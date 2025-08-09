import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/product/data/models/product_model.dart';
import 'package:bingo/features/product/domain/entity/product.dart';

abstract class ProductRepo {
  Future<List<ProductEntity>> getAllProduct();
  Future<List<ProductEntity>> getProductsByShopId(String shopId);
  Future<BaseResponse> createProduct(ProductModel product);
}
