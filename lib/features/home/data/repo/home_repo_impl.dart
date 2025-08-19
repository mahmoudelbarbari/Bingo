import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/home/data/datasource/home_datasource.dart';
import 'package:bingo/features/home/data/models/category_model.dart.dart';
import 'package:bingo/features/home/domain/repo/home_repo.dart';
import 'package:bingo/features/product/data/models/product_model.dart';
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

  @override
  Future<BaseResponse> addToWishList(String productId) async {
    return await homeDatasource.addToWishList(productId);
  }

  @override
  Future<BaseResponse> clearWishlist() async {
    return await homeDatasource.clearWishlist();
  }

  @override
  Future<List<ProductModel>> getWishlistItems() async {
    return await homeDatasource.getWishlistItems();
  }

  @override
  Future<bool> isInWishlist(String productId) async {
    return await homeDatasource.isInWishlist(productId);
  }

  @override
  Future<BaseResponse> removeFromWishlist(String productId) async {
    return await homeDatasource.removeFromWishlist(productId);
  }
}
