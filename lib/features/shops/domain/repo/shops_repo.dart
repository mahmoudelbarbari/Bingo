import 'dart:io';

import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/shops/domain/entity/shop_entity.dart';

abstract class ShopsRepo {
  Future<BaseResponse> addShop(ShopEntity shopEntity, File imageFile);
}
