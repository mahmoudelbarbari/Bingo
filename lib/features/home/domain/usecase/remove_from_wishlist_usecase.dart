import '../../../../core/util/base_response.dart';
import '../repo/home_repo.dart';

class RemoveFromWishlistUsecase {
  final HomeRepo homeRepo;

  RemoveFromWishlistUsecase(this.homeRepo);

  Future<BaseResponse> call(String productId) async {
    return await homeRepo.removeFromWishlist(productId);
  }
}
