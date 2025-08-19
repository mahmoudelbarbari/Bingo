import 'package:bingo/features/home/domain/repo/home_repo.dart';

class IsInWishlistUsecase {
  final HomeRepo _homeRepo;

  IsInWishlistUsecase(this._homeRepo);

  Future<bool> call(String productId) async {
    return await _homeRepo.isInWishlist(productId);
  }
}
