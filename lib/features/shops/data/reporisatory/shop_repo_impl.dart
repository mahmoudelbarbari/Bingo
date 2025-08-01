import 'dart:io';

import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/shops/data/datasource/shop_datasource.dart';
import 'package:bingo/features/shops/data/models/shop_model.dart';
import 'package:bingo/features/shops/domain/entity/shop_entity.dart';
import 'package:bingo/features/shops/domain/repo/shops_repo.dart';

class ShopRepoImpl implements ShopsRepo {
  final ShopDatasource shopDatasource;

  ShopRepoImpl(this.shopDatasource);

  @override
  Future<BaseResponse> addShop(ShopEntity shopEntity, File imageFile) async {
    return await shopDatasource.addShop(
      ShopModel.fromEntity(shopEntity),
      imageFile,
    );
  }
}
