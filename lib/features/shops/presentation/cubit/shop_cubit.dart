import 'dart:io';

import 'package:bingo/config/injection_container.dart';
import 'package:bingo/features/auth/register/data/model/register_model.dart';
import 'package:bingo/features/shops/domain/entity/shop_entity.dart';
import 'package:bingo/features/shops/domain/usecase/add_shop_image.dart';
import 'package:bingo/features/shops/domain/usecase/add_shop_usecase.dart';
import 'package:bingo/features/shops/presentation/cubit/shop_state.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopState> {
  late AddShopUsecase addShopUsecase;
  late AddShopImage addShopImageUsecase;

  ShopCubit() : super(ShopStateInit());

  Future<void> addShop(
    BuildContext context,
    ShopEntity shopEntity,
    SellerAccountModel sellerAccountModel,
  ) async {
    final loc = AppLocalizations.of(context)!;

    emit(ShopLoadingState());
    try {
      addShopUsecase = sl();
      final response = await addShopUsecase.call(
        shopEntity,
        sellerAccountModel,
      );
      if (response.status) {
        emit(ShopSuccessState(loc.shopAddedSuccessfuly));
      } else {
        emit(ShopErrorState('${loc.faildToAddShop} : ${response.message}'));
      }
    } catch (e) {
      emit(ShopErrorState('${loc.faildToAddShop} ${e.toString()}'));
    }
  }

  Future<void> addShopImage(File imageFile) async {
    emit(ShopLoadingState());
    try {
      addShopImageUsecase = sl();
      await addShopImageUsecase.call(imageFile);
      emit(ImageShopSuccessState('Image Uploaded'));
    } catch (e) {
      emit(ShopErrorState('Faild To upload Image ${e.toString()}'));
    }
  }
}
