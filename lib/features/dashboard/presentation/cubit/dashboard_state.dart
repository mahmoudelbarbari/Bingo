import 'package:bingo/features/dashboard/domain/entity/shop_stats_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
