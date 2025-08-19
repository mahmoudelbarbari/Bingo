import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/home/data/models/category_model.dart.dart';

import '../../../product/data/models/product_model.dart';
import '../../../product/domain/entity/product.dart';

abstract class HomeRepo {
  Future<CategoryModel> getCategories();
  Future<List<ProductEntity>> getThreeProduct();
  Future<List<ProductEntity>> searchProduct(String query);
  Future<BaseResponse> addToWishList(String productId);
  
  Future<List<ProductModel>> getWishlistItems();
  Future<BaseResponse> removeFromWishlist(String productId);
  Future<BaseResponse> clearWishlist();
  Future<bool> isInWishlist(String productId);
}
