import 'package:bingo/config/injection_container.dart';
import 'package:bingo/features/dashboard/domain/entity/discount_code_entity.dart';
import 'package:bingo/features/dashboard/domain/usecases/add_discount_code_usecase.dart';
import 'package:bingo/features/dashboard/domain/usecases/delete_discount_code_usecase.dart';
import 'package:bingo/features/dashboard/domain/usecases/get_discount_code_usecase.dart';
import 'package:bingo/features/dashboard/domain/usecases/get_shop_stats_usecase.dart';
import 'package:bingo/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/handler_request_api.dart';
import '../../domain/usecases/get_revenue_data.dart';

class DashboardCubit extends Cubit<DashboardState> {
  late GetRevenueData getRevenueData;
  late GetShopStatsUsecase getShopStatsUsecase;
  late AddDiscountCodeUsecase addDiscountCodeUsecase;
  late GetDiscountCodeUsecase getDiscountCodeUsecase;
  late DeleteDiscountCodeUsecase deleteDiscountCodeUsecase;

  DashboardCubit() : super(DashboardInitial());

  Future<void> fetchRevenueData() async {
    getRevenueData = sl();
    getShopStatsUsecase = sl();
    emit(DashboardLoading());
    try {
      final revenueData = await getRevenueData.call();
      final shopStats = await getShopStatsUsecase.call();
      emit(DashboardLoaded(revenueData, shopStats));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }

  Future<void> addDiscountCode(
    DiscountCodeEntity discountCodeEntity,
    BuildContext context,
  ) async {
    addDiscountCodeUsecase = sl();
    emit(AddDiscountCodeLoading());
    try {
      await handlerRequestApi(
        context: context,
        body: () async {
          final result = await addDiscountCodeUsecase.call(discountCodeEntity);
          if (result.status) {
            emit(AddDiscountCodeSuccess());
          } else {
            emit(AddDiscountCodeError(result.message));
          }
        },
      );
    } catch (e) {
      emit(AddDiscountCodeError(e.toString()));
    }
  }

  Future<void> getDiscountCodes() async {
    getDiscountCodeUsecase = sl();
    emit(GetDiscountCodesLoading());
    try {
      final result = await getDiscountCodeUsecase.call();
      emit(GetDiscountCodesSuccess(result));
    } catch (e) {
      emit(GetDiscountCodesError(e.toString()));
    }
  }

  Future<void> deleteDiscountCode(
    String discountCodeId,
    BuildContext context,
  ) async {
    deleteDiscountCodeUsecase = sl();
    emit(DeleteDiscountCodeLoading());
    try {
      await handlerRequestApi(
        context: context,
        body: () async {
          final result = await deleteDiscountCodeUsecase.call(discountCodeId);
          if (result.status) {
            emit(DeleteDiscountCodeSuccess());
          } else {
            emit(DeleteDiscountCodeError(result.message));
          }
        },
      );
    } catch (e) {
      emit(DeleteDiscountCodeError(e.toString()));
    }
  }
}
