import 'package:bingo/features/dashboard/domain/entity/shop_stats_entity.dart';

import '../entity/revenue_data_entity.dart';

abstract class DashboardRepository {
  Future<List<RevenueDataEntity>> getRevenueData();
  Future<ShopStatsEntity> getShopStats();
}
