import '../entity/revenue_data_entity.dart';
import '../repo/dashboard_repository.dart';

class GetRevenueData {
  final DashboardRepository repository;

  GetRevenueData(this.repository);

  Future<List<RevenueDataEntity>> call() async {
    return await repository.getRevenueData();
  }
}
