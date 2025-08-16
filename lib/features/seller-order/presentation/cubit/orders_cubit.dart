import 'package:bingo/config/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/order_model.dart';
import '../../domain/usecase/get_recent_orders_usecase.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  late GetRecentOrdersUsecase getRecentOrdersUsecase;

  OrdersCubit() : super(OrdersInitial());

  Future<void> loadRecentOrders({int limit = 5}) async {
    getRecentOrdersUsecase = sl();
    emit(OrdersLoading());
    try {
      final orders = await getRecentOrdersUsecase.call(limit: limit);
      emit(OrdersLoaded(orders));
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  List<ShopOrder> filterByStatus(String status, List<ShopOrder> allOrders) {
    return allOrders.where((order) => order.status == status).toList();
  }
}
