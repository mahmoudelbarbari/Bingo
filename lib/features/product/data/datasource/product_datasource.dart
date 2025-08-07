import 'package:bingo/core/network/dio_provider.dart';
import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/product/data/models/product_model.dart';
import 'package:bingo/features/product/domain/entity/product.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductDatasource {
  Future<List<ProductEntity>> getAllProduct();
  Future<BaseResponse> createProduct(ProductModel product);
}

class ProductDatasourceImpl implements ProductDatasource {
  final Future<Dio> _dioFuture = DioClient.createDio(ApiTarget.product);

  @override
  Future<List<ProductEntity>> getAllProduct() async {
    try {
      final dio = await _dioFuture;
      final response = await dio.get('get-all-products');

      if (response.statusCode == 200) {
        final data = response.data;

        final List<dynamic> productData = data is List
            ? data
            : (data is Map && data['products'] is List)
            ? data['products']
            : throw Exception('Unexpected response format');

        return productData
            .cast<Map<String, dynamic>>()
            .map((item) => ProductModel.fromJson(item))
            .cast<ProductEntity>()
            .toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  @override
  Future<BaseResponse> createProduct(ProductModel product) async {
    try {
      final dio = await _dioFuture;
      final prefs = await SharedPreferences.getInstance();
      final role = prefs.getString('auth_role');

      if (role != 'seller') {
        return BaseResponse(
          status: false,
          message: 'Only sellers can create products',
        );
      }

      final response = await dio.post('create-product', data: product.toJson());

      if (response.statusCode == 200) {
        return BaseResponse(
          status: true,
          message: 'Product created successfully',
        );
      } else {
        return BaseResponse(
          status: false,
          message: 'Failed: ${response.statusMessage}',
        );
      }
    } catch (e) {
      return BaseResponse(status: false, message: 'Error: $e');
    }
  }
}
