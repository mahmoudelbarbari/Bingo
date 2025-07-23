import 'package:bingo/features/profile/data/datasource/product_datasource.dart';
import 'package:bingo/features/profile/domain/entity/product.dart';
import 'package:bingo/features/profile/domain/repo/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  final ProductDatasource productDatasource;
  ProductRepoImpl(this.productDatasource);

  @override
  Future<List<ProductEntity>> getAllProduct() async {
    return await productDatasource.getAllProduct();
  }
}
