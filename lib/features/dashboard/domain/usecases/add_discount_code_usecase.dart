import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/dashboard/domain/entity/discount_code_entity.dart';
import 'package:bingo/features/dashboard/domain/repo/dashboard_repository.dart';

class AddDiscountCodeUsecase {
  final DashboardRepository _dashboardRepository;

  AddDiscountCodeUsecase(this._dashboardRepository);

  Future<BaseResponse> call(DiscountCodeEntity discountCodeEntity) async =>
      await _dashboardRepository.addDiscountCode(discountCodeEntity);
}
