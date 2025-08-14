import 'package:bingo/features/dashboard/domain/entity/shop_stats_entity.dart';
import 'package:bingo/features/dashboard/domain/repo/dashboard_repository.dart';

class GetShopStatsUsecase {
  final DashboardRepository _dashboardRepository;

  GetShopStatsUsecase(this._dashboardRepository);

  Future<ShopStatsEntity> call() async =>
      await _dashboardRepository.getShopStats();
}
