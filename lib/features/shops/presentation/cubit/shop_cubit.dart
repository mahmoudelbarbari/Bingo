import 'dart:io';

import 'package:bingo/config/injection_container.dart';
import 'package:bingo/core/errors/handler_request_api.dart';
import 'package:bingo/features/shops/domain/entity/shop_entity.dart';
import 'package:bingo/features/shops/domain/usecase/add_shop_usecase.dart';
import 'package:bingo/features/shops/presentation/cubit/shop_state.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopState> {
  late AddShopUsecase addShopUsecase;

  ShopCubit() : super(ShopStateInit());

  Future<void> addShop(
    BuildContext context,
    ShopEntity shopEntity,
    File imageFile,
  ) async {
    final loc = AppLocalizations.of(context)!;
    emit(ShopLoadingState());

    try {
      addShopUsecase = sl();
      handlerRequestApi(
        context: context,
        body: () async {
          await addShopUsecase.call(shopEntity, imageFile);
          emit(ShopSuccessState(loc.shopAddedSuccessfuly));
        },
      );
    } catch (e) {
      emit(ShopErrorState('${loc.faildToAddShop} ${e.toString()}'));
    }
  }
}
