import '../../../../core/util/base_response.dart';
import '../repo/home_repo.dart';

class AddToWishlistUsecase {
  final HomeRepo _homeRepo;

  AddToWishlistUsecase(this._homeRepo);

  Future<BaseResponse> call(String productId) async {
    return await _homeRepo.addToWishList(productId);
  }
}
