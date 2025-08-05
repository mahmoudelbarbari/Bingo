import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/shops/domain/entity/shop_entity.dart';
import 'package:bingo/features/shops/domain/repo/shops_repo.dart';

import '../../../auth/register/data/model/register_model.dart';

class AddShopUsecase {
  final ShopsRepo shopsRepo;

  AddShopUsecase(this.shopsRepo);

  Future<BaseResponse> call(
    ShopEntity shopEntity,
    SellerAccountModel sellerAccountModel,
  ) async => await shopsRepo.addShop(shopEntity, sellerAccountModel);
}
