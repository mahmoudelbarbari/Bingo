import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/product/data/datasource/product_datasource.dart';
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
  Future<BaseResponse> createProduct(ProductEntity product) async {
    // TODO: implement createProduct
    throw UnimplementedError();
  }
}
