import 'package:dio/dio.dart';

import '../../../../core/network/dio_provider.dart';
import '../models/order_model.dart';

abstract class SellerOrderDatasource {
  Future<List<ShopOrder>> getRecentOrders({int limit = 5});
}

class SellerOrderDatasourceImpl implements SellerOrderDatasource {
  final Future<Dio> _dioFuture = DioClient.createDio(ApiTarget.seller);
  @override
  Future<List<ShopOrder>> getRecentOrders({int limit = 5}) async {
    try {
      final dio = await _dioFuture;

      final response = await dio.get(
        'dashboard/recent-orders',
        queryParameters: {'limit': limit},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return (response.data as List)
            .map((json) => ShopOrder.fromJson(json))
            .toList();
      } else {
        throw Exception('Something went wrong ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Something went wrong ${e.toString()}');
    }
  }
}
