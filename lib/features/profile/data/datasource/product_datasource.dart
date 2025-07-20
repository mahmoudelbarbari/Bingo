import 'package:bingo/features/profile/data/model/product_model.dart';
import 'package:bingo/features/profile/domain/entity/product.dart';
import 'package:dio/dio.dart';

abstract class ProductDatasource {
  Future<List<ProductEntity>> getAllProduct();
}

class ProductDatasourceImpl implements ProductDatasource {
  final Dio dio;

  ProductDatasourceImpl(this.dio);

  @override
  Future<List<ProductEntity>> getAllProduct() async {
    try {
      final response = await dio.get('/product/api/get-shop-products');

      if (response.statusCode == 200) {
        final data = response.data;

        // Make sure the response is a list
        if (data is List) {
          // Parse each item in the list to a ProductModel
          return data
              .map((item) => ProductModel.fromMap(item as Map<String, dynamic>))
              .toList();
        } else if (data is Map && data['products'] is List) {
          // In case products are nested
          return (data['products'] as List)
              .map((item) => ProductModel.fromMap(item as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
