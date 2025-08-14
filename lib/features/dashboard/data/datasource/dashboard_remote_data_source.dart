import 'package:bingo/features/dashboard/data/models/shop_stats_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/dio_provider.dart';
import '../models/revenue_data_model.dart';

abstract class DashboardRemoteDataSource {
  Future<List<RevenueDataModel>> getRevenueData();
  Future<ShopStatsModel> getShopStats();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final Future<Dio> _dioFuture = DioClient.createDio(ApiTarget.seller);

  DashboardRemoteDataSourceImpl();

  @override
  Future<List<RevenueDataModel>> getRevenueData() async {
    try {
      final dio = await _dioFuture;
      final response = await dio.get('dashboard/revenue');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return List<RevenueDataModel>.from(
          response.data.map((x) => RevenueDataModel.fromJson(x)),
        );
      } else {
        throw ('Something went wrong ${response.statusMessage}');
      }
    } catch (e) {
      throw ('Something went wrong $e');
    }
  }

  @override
  Future<ShopStatsModel> getShopStats() async {
    try {
      final dio = await _dioFuture;
      final response = await dio.get('dashboard/shop-stats');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ShopStatsModel.fromJson(response.data);
      } else {
        throw ('Something went worng ${response.statusMessage}');
      }
    } catch (e) {
      throw ('Something went worng ${e.toString()}');
    }
  }
}
