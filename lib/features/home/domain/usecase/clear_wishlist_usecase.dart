import '../../../../core/util/base_response.dart';
import '../repo/home_repo.dart';

class ClearWishlistUsecase {
  final HomeRepo _homeRepo;

  ClearWishlistUsecase(this._homeRepo);

  Future<BaseResponse> call() async {
    return await _homeRepo.clearWishlist();
  }
}
