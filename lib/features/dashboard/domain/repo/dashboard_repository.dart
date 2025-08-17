import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/dashboard/domain/entity/shop_stats_entity.dart';

import '../entity/discount_code_entity.dart';
import '../entity/revenue_data_entity.dart';

abstract class DashboardRepository {
  Future<List<RevenueDataEntity>> getRevenueData();
  Future<ShopStatsEntity> getShopStats();
  Future<BaseResponse> addDiscountCode(DiscountCodeEntity discountCodeEntity);
  Future<List<DiscountCodeEntity>> getDiscountCodes();
  Future<BaseResponse> deleteDiscountCode(String discountCodeId);
}
