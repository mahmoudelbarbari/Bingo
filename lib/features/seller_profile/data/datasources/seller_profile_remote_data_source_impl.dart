import 'package:bingo/features/shops/data/models/shop_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/helper/token_storage.dart';
import '../../../../core/network/dio_provider.dart';
import '../models/seller_profile_model.dart';
import '../models/product_model.dart';
import '../models/event_model.dart';
import '../models/review_model.dart';

abstract class SellerProfileRemoteDataSource {
  Future<SellerProfileModel> getSellerProfile(String sellerId);
  Future<List<ProductProfileModel>> getSellerProducts(String sellerId);
  Future<List<EventModel>> getSellerEvents(String sellerId);
  Future<List<ReviewModel>> getSellerReviews(String sellerId);
  Future<ShopModel> getSellerData();
}

class SellerProfileRemoteDataSourceImpl
    implements SellerProfileRemoteDataSource {
  final Future<Dio> _dioFuture = DioClient.createDio(ApiTarget.seller);
  final Future<Dio> _dioAuth = DioClient.createDio(ApiTarget.auth);
  @override
  Future<SellerProfileModel> getSellerProfile(String sellerId) async {
    try {
      final dio = await _dioFuture;
      final response = await dio.get('get-seller/$sellerId');

      print('THIS IS SELLER DATA ${response.data}'); // ← No trailing slash
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SellerProfileModel.fromMap(response.data);
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  @override
  Future<List<ProductProfileModel>> getSellerProducts(String sellerId) async {
    try {
      final dio = await _dioFuture;

      final sellerData = await TokenStorage.getLoggedUserData();
      String? shopId;
      if (sellerData?['shop'] != null && sellerData?['shop'] is Map) {
        final shopData = sellerData?['shop'] as Map<String, dynamic>;
        shopId = shopData['id']?.toString();
      }
      if (shopId == null || shopId.isEmpty) {
        throw Exception(
          'No shop found for this seller. Please create a shop first.',
        );
      }

      final response = await dio.get('get-seller-products/$shopId');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('products')) {
          final productsList = responseData['products'] as List;

          return productsList
              .map((product) => ProductProfileModel.fromMap(product))
              .toList();
        } else if (responseData is List) {
          return responseData
              .map((product) => ProductProfileModel.fromMap(product))
              .toList();
        }
        // Fallback
        else {
          throw Exception(
            'Unexpected response format: ${responseData.runtimeType}',
          );
        }
      } else {
        throw Exception(
          'Failed to get seller products: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error getting seller products: $e');
    }
  }

  @override
  Future<List<EventModel>> getSellerEvents(String sellerId) async {
    try {
      final dio = await _dioFuture;
      final response = await dio.get('get-seller-events/$sellerId');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;

        // Handle wrapped response
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('products')) {
          final eventsList = responseData['products'] as List;
          return eventsList.map((e) => EventModel.fromJson(e)).toList();
        }
        // Handle direct list
        else if (responseData is List) {
          return responseData.map((e) => EventModel.fromJson(e)).toList();
        } else {
          throw Exception(
            'Unexpected response format: ${responseData.runtimeType}',
          );
        }
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  @override
  Future<List<ReviewModel>> getSellerReviews(String sellerId) async {
    try {
      final dio = await _dioFuture;
      final response = await dio.get('get-reviews/$sellerId');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((e) => ReviewModel.fromJson(e)).toList();
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  String _handleDioError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      return e.response?.data['message'] ??
          e.response?.data['error'] ??
          e.message ??
          'Unknown error';
    }
    return e.message ?? 'Network error occurred';
  }

  @override
  Future<ShopModel> getSellerData() async {
    try {
      final dioAuth = await _dioAuth;
      final response = await dioAuth.get('logged-in-seller');
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['seller']['shop'] == null) {
          throw Exception(
            'Shop data not found in response ${response.statusMessage}',
          );
        }
        return ShopModel.fromJson(response.data['seller']['shop']);
      } else {
        throw Exception('Something went wrong ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Something went wrong $e');
    }
  }
}
