import 'package:bingo/config/injection_container.dart';
import 'package:bingo/features/dashboard/domain/usecases/get_shop_stats_usecase.dart';
import 'package:bingo/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_revenue_data.dart';

class DashboardCubit extends Cubit<DashboardState> {
  late GetRevenueData getRevenueData;
  late GetShopStatsUsecase getShopStatsUsecase;

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
}
