import 'package:bingo/features/dashboard/domain/entity/shop_stats_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/discount_code_entity.dart';
import '../../domain/entity/revenue_data_entity.dart';

@immutable
abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<RevenueDataEntity> revenueData;
  final ShopStatsEntity shopStatsEntity;
  const DashboardLoaded(this.revenueData, this.shopStatsEntity);

  @override
  List<Object> get props => [revenueData];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object> get props => [message];
}

class AddDiscountCodeLoading extends DashboardState {}

class AddDiscountCodeSuccess extends DashboardState {}

class AddDiscountCodeError extends DashboardState {
  final String message;

  const AddDiscountCodeError(this.message);
}

class DeleteDiscountCodeLoading extends DashboardState {}

class DeleteDiscountCodeSuccess extends DashboardState {}

class DeleteDiscountCodeError extends DashboardState {
  final String message;

  const DeleteDiscountCodeError(this.message);
}

class GetDiscountCodesLoading extends DashboardState {}

class GetDiscountCodesSuccess extends DashboardState {
  final List<DiscountCodeEntity> discountCodes;

  const GetDiscountCodesSuccess(this.discountCodes);
}

class GetDiscountCodesError extends DashboardState {
  final String message;

  const GetDiscountCodesError(this.message);
}
