import 'package:bingo/features/home/data/datasource/home_datasource.dart';
import 'package:bingo/features/home/data/models/category_model.dart.dart';
import 'package:bingo/features/home/domain/repo/home_repo.dart';
import 'package:bingo/features/product/domain/entity/product.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeDatasource homeDatasource;

  HomeRepoImpl(this.homeDatasource);

  @override
  Future<CategoryModel> getCategories() async {
    return await homeDatasource.getCategories();
  }

  @override
  Future<List<ProductEntity>> getThreeProduct() async {
    return await homeDatasource.getThreeProduct();
  }

  @override
  Future<List<ProductEntity>> searchProduct(String query) async {
    return await homeDatasource.searchProduct(query);
  }
}
