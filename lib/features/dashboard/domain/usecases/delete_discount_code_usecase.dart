import '../../../../core/util/base_response.dart';
import '../repo/dashboard_repository.dart';

class DeleteDiscountCodeUsecase {
  final DashboardRepository _dashboardRepository;

  DeleteDiscountCodeUsecase(this._dashboardRepository);

  Future<BaseResponse> call(String discountCodeId) async {
    return await _dashboardRepository.deleteDiscountCode(discountCodeId);
  }
}
