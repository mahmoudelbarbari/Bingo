import 'package:bingo/features/dashboard/domain/entity/discount_code_entity.dart';

import '../repo/dashboard_repository.dart';

class GetDiscountCodeUsecase {
  final DashboardRepository _dashboardRepository;

  GetDiscountCodeUsecase(this._dashboardRepository);

  Future<List<DiscountCodeEntity>> call() async {
    return await _dashboardRepository.getDiscountCodes();
  }
}
