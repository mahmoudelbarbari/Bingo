import 'package:bingo/core/network/dio_provider.dart';
import 'package:bingo/features/home/data/models/category_model.dart.dart';
import 'package:bingo/features/product/data/models/product_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/helper/token_storage.dart';
import '../../../../core/util/base_response.dart';

abstract class HomeDatasource {
  Future<CategoryModel> getCategories();
  Future<List<ProductModel>> getThreeProduct();
  Future<List<ProductModel>> searchProduct(String query);
  Future<BaseResponse> addToWishList(String productId);

  Future<List<ProductModel>> getWishlistItems();
  Future<BaseResponse> removeFromWishlist(String productId);
  Future<BaseResponse> clearWishlist();
  Future<bool> isInWishlist(String productId);
}

class HomeDatasourceImpl implements HomeDatasource {
  final Future<Dio> _dioFuture = DioClient.createDio(ApiTarget.product);

  @override
  Future<CategoryModel> getCategories() async {
    try {
      final dio = await _dioFuture;
      final response = await dio.get('get-categories');
      if (response.statusCode == 200) {
        return CategoryModel.fromJson(response.data);
      } else {
        throw Exception('Faild to load categories ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load categories: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<List<ProductModel>> getThreeProduct() async {
    try {
      final dio = await _dioFuture;
      final response = await dio.get(
        'get-all-products?page=1&limit=3&includeShop=true',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> productData = response.data['products'];
        final List<ProductModel> products = productData
            .map((productJson) => ProductModel.fromJson(productJson))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: ${e.toString()}');
    }
  }

  @override
  Future<List<ProductModel>> searchProduct(String query) async {
    try {
      final dio = await _dioFuture;
      final response = await dio.get(
        'search-products',
        queryParameters: {'q': query},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = response.data['products'];
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Something wnet wrong ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Error: ${e.response?.statusCode}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Server error ${e.toString()}');
    }
  }

  @override
  Future<BaseResponse> addToWishList(String productId) async {
    try {
      final dio = await _dioFuture;
      final userData = await TokenStorage.getLoggedUserData();
      String? userId;
      if (userData != null) {
        final shopData = userData;
        userId = shopData['id']?.toString();
      }
      if (userId == null || userId.isEmpty) {
        return BaseResponse(status: false, message: 'User not authenticated.');
      }
      final response = await dio.post(
        'wishlist/add',
        data: {'productId': productId},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await TokenStorage.getToken()}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return BaseResponse(status: true, message: 'Product added to wishlist');
      } else {
        return BaseResponse(
          status: false,
          message:
              'Failed to add product to wishlist ${response.statusMessage}',
        );
      }
    } catch (e) {
      return BaseResponse(
        status: false,
        message: 'Failed to add product to wishlist ${e.toString()}',
      );
    }
  }

  @override
  Future<BaseResponse> clearWishlist() async {
    try {
      final dio = await _dioFuture;
      final accessToken = await TokenStorage.getToken();

      final response = await dio.delete(
        'wishlist/clear',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return BaseResponse(status: true, message: 'Wishlist cleared');
      } else {
        return BaseResponse(
          status: false,
          message: 'Failed to clear wishlist ${response.statusMessage}',
        );
      }
    } catch (e) {
      return BaseResponse(
        status: false,
        message: 'Failed to clear wishlist ${e.toString()}',
      );
    }
  }

  @override
  Future<List<ProductModel>> getWishlistItems() async {
    try {
      final dio = await _dioFuture;
      final accessToken = await TokenStorage.getToken();

      final response = await dio.get(
        'wishlist',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> productData = response.data['wishlist'] ?? [];
        final List<ProductModel> products = productData
            .map((productJson) => ProductModel.fromJson(productJson))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load wishlist: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load wishlist: ${e.toString()}');
    }
  }

  @override
  Future<bool> isInWishlist(String productId) async {
    try {
      final dio = await _dioFuture;
      final accessToken = await TokenStorage.getToken();

      final response = await dio.get(
        'wishlist/check/$productId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['isInWishlist'] ?? false;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<BaseResponse> removeFromWishlist(String productId) async {
    try {
      final dio = await _dioFuture;
      final accessToken = await TokenStorage.getToken();

      final response = await dio.delete(
        'wishlist/remove/$productId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return BaseResponse(
          status: true,
          message: 'Product removed from wishlist',
        );
      } else {
        return BaseResponse(
          status: false,
          message:
              'Failed to remove product from wishlist ${response.statusMessage}',
        );
      }
    } catch (e) {
      return BaseResponse(
        status: false,
        message: 'Failed to remove product from wishlist ${e.toString()}',
      );
    }
  }
}
