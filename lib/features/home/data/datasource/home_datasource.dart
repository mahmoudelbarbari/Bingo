import 'package:bingo/core/network/dio_provider.dart';
import 'package:bingo/features/home/data/models/category_model.dart.dart';
import 'package:dio/dio.dart';

abstract class HomeDatasource {
  Future<CategoryModel> getCategories();
}

class HomeDatasourceImpl implements HomeDatasource {
  final Dio _dio = createDio(ApiTarget.product);

  @override
  Future<CategoryModel> getCategories() async {
    try {
      final response = await _dio.get('get-categories');
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
}
