import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/product/data/datasource/product_datasource.dart';
import 'package:bingo/features/product/data/models/product_model.dart';
import 'package:bingo/features/product/domain/entity/product.dart';
import 'package:bingo/features/product/domain/repo/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  final ProductDatasource productDatasource;
  ProductRepoImpl(this.productDatasource);

  @override
  Future<List<ProductEntity>> getAllProduct() async {
    return await productDatasource.getAllProduct();
  }

  @override
  Future<List<ProductEntity>> getProductsByShopId(String shopId) async {
    return await productDatasource.getProductsByShopId(shopId);
  }

  @override
  Future<BaseResponse> createProduct(ProductModel product) async {
    return await productDatasource.createProduct(product);
  }
}
