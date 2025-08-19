import 'package:bingo/features/shops/domain/repo/shops_repo.dart';

import '../entity/shop_entity.dart';

class GetBestSellersShopsUsecase {
  final ShopsRepo _shopsRepo;

  GetBestSellersShopsUsecase(this._shopsRepo);

  Future<List<ShopEntity>> call() async {
    return await _shopsRepo.getBestSellers();
  }
}
