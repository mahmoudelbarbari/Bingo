import 'package:bingo/core/network/dio_provider.dart';
import 'package:bingo/features/home/data/models/category_model.dart.dart';
import 'package:bingo/features/product/data/models/product_model.dart';
import 'package:dio/dio.dart';

abstract class HomeDatasource {
  Future<CategoryModel> getCategories();
  Future<List<ProductModel>> getThreeProduct();
  Future<List<ProductModel>> searchProduct(String query);
}

class HomeDatasourceImpl implements HomeDatasource {
  final Future<Dio> _dioFuture = DioClient.createDio(ApiTarget.product);

  @override
  Future<CategoryModel> getCategories() async {
    try {
      final dio = await _dioFuture;
      final response = await dio.get('get-categories');
      final test = await dio.get('search-products');
      print('THIS IS DAMCIAAAAAA ${test.data}');

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
}
