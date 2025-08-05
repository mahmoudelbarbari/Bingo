import 'dart:io';

import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/auth/register/data/model/register_model.dart';
import 'package:bingo/features/shops/data/datasource/shop_datasource.dart';
import 'package:bingo/features/shops/data/models/shop_model.dart';
import 'package:bingo/features/shops/domain/entity/shop_entity.dart';
import 'package:bingo/features/shops/domain/repo/shops_repo.dart';

class ShopRepoImpl implements ShopsRepo {
  final ShopDatasource shopDatasource;

  ShopRepoImpl(this.shopDatasource);

  @override
  Future<BaseResponse> addShop(
    ShopEntity shopEntity,
    SellerAccountModel sellerAccountModel,
  ) async {
    return await shopDatasource.addShop(
      ShopModel.fromEntity(shopEntity),
      sellerAccountModel,
    );
  }

  @override
  Future<void> addShopImage(File imageFile) async {
    // TODO: implement addShopImage
    throw UnimplementedError();
  }
}
