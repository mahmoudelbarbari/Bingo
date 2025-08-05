import 'dart:io';

import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/auth/register/data/model/register_model.dart';
import 'package:bingo/features/shops/domain/entity/shop_entity.dart';

abstract class ShopsRepo {
  Future<void> addShopImage(File imageFile);
  Future<BaseResponse> addShop(
    ShopEntity shopEntity,
    SellerAccountModel sellerAccountModel,
  );
}
