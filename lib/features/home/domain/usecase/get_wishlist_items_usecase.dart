import 'package:bingo/features/home/domain/repo/home_repo.dart';

import '../../../product/data/models/product_model.dart';

class GetWishlistItemsUsecase {
  final HomeRepo _homeRepo;

  GetWishlistItemsUsecase(this._homeRepo);

  Future<List<ProductModel>> call() async {
    return await _homeRepo.getWishlistItems();
  }
}
