import 'package:dio/dio.dart';

import '../../../../core/helper/token_storage.dart';
import '../../../../core/network/dio_provider.dart';
import '../models/seller_profile_model.dart';
import '../models/product_model.dart';
import '../models/event_model.dart';
import '../models/review_model.dart';

// class SellerProfileRemoteDataSourceImpl implements SellerProfileRemoteDataSource {
//   final http.Client client;
//   static const String baseUrl = 'http://localhost:6003/api';
//   static const Map<String, String> headers = {'Content-Type': 'application/json'};

//   SellerProfileRemoteDataSourceImpl({required this.client});

//   @override
//   Future<SellerProfileModel> getSellerProfile(String sellerId) async {
//     final response = await client.get(
//       Uri.parse('$baseUrl/get-seller/$sellerId'),
//       headers: headers,
//     );
//     return _handleResponse(response, (data) => SellerProfileModel.fromMap(data));
//   }

//   @override
//   Future<List<ProductModel>> getSellerProducts(String sellerId) async {
//     final response = await client.get(
//       Uri.parse('$baseUrl/get-seller-products/$sellerId'),
//       headers: headers,
//     );
//     return _handleListResponse(response, (e) => ProductModel.fromMap(e));
//   }

//   @override
//   Future<List<EventModel>> getSellerEvents(String sellerId) async {
//     final response = await client.get(
//       Uri.parse('$baseUrl/get-seller-events/$sellerId'),
//       headers: headers,
//     );
//     return _handleListResponse(response, (e) => EventModel.fromJson(e));
//   }

//   @override
//   Future<List<ReviewModel>> getSellerReviews(String sellerId) async {
//     final response = await client.get(
//       Uri.parse('$baseUrl/get-reviews/$sellerId'),
//       headers: headers,
//     );
//     return _handleListResponse(response, (e) => ReviewModel.fromJson(e));
//   }

//   T _handleResponse<T>(http.Response response, T Function(dynamic) parser) {
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return parser(data);
//     } else {
//       throw Exception('Failed to load data: ${response.statusCode}');
//     }
//   }

//   List<T> _handleListResponse<T>(http.Response response, T Function(dynamic) parser) {
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       return data.map(parser).toList();
//     } else {
//       throw Exception('Failed to load list data: ${response.statusCode}');
//     }
//   }
// }
//Convert it  to dio
//

abstract class SellerProfileRemoteDataSource {
  Future<SellerProfileModel> getSellerProfile(String sellerId);
  Future<List<ProductProfileModel>> getSellerProducts(String sellerId);
  Future<List<EventModel>> getSellerEvents(String sellerId);
  Future<List<ReviewModel>> getSellerReviews(String sellerId);
}

class SellerProfileRemoteDataSourceImpl
    implements SellerProfileRemoteDataSource {
  final Future<Dio> _dioFuture = DioClient.createDio(ApiTarget.seller);

  @override
  Future<SellerProfileModel> getSellerProfile(String sellerId) async {
    try {
      final dio = await _dioFuture;
      final response = await dio.get(
        'get-seller/$sellerId',
      ); // ← No trailing slash

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

      // Get the shopId for this seller
      final shopId = await TokenStorage.getShopId();

      if (shopId == null || shopId.isEmpty) {
        throw Exception(
          'No shop found for this seller. Please create a shop first.',
        );
      }

      print('🔍 Fetching products for shop ID: $shopId (seller: $sellerId)');
      print(' Making request to: get-seller-products/$shopId');

      final response = await dio.get(
        'get-seller-products/$shopId', // ← Use shopId instead of sellerId
      );

      print('📥 Response status: ${response.statusCode}');
      print('📥 Response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Handle the wrapped response structure
        final responseData = response.data;

        // Check if response has 'products' key (wrapped response)
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('products')) {
          final productsList = responseData['products'] as List;
          print('📦 Found ${productsList.length} products in response');

          if (productsList.isEmpty) {
            print(
              '⚠️ Products list is empty - seller might not have created products yet',
            );
          }

          return productsList
              .map((product) => ProductProfileModel.fromMap(product))
              .toList();
        }
        // Check if response is directly a list
        else if (responseData is List) {
          print('📦 Found ${responseData.length} products in direct list');
          return responseData
              .map((product) => ProductProfileModel.fromMap(product))
              .toList();
        }
        // Fallback
        else {
          print('❌ Unexpected response format: ${responseData.runtimeType}');
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
      print('❌ Error in getSellerProducts: $e');
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
}
