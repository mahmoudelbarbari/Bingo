import 'package:bingo/features/dashboard/data/datasource/dashboard_remote_data_source.dart';
import 'package:bingo/features/dashboard/domain/entity/revenue_data_entity.dart';
import 'package:bingo/features/dashboard/domain/entity/shop_stats_entity.dart';
import 'package:bingo/features/dashboard/domain/repo/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource dashboardRemoteDataSource;

  DashboardRepositoryImpl(this.dashboardRemoteDataSource);

  @override
  Future<List<RevenueDataEntity>> getRevenueData() async {
    final models = await dashboardRemoteDataSource.getRevenueData();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<ShopStatsEntity> getShopStats() async {
    final model = await dashboardRemoteDataSource.getShopStats();
    return model.toEntity();
  }
}
