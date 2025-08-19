part of 'best_sellers_cubit.dart';

abstract class BestSellersState {
  const BestSellersState();
}

class BestSellersInitial extends BestSellersState {}

class BestSellersLoading extends BestSellersState {}

class BestSellersLoaded extends BestSellersState {
  final List<ShopEntity> shops;

  const BestSellersLoaded({required this.shops});
}

class BestSellersError extends BestSellersState {
  final String message;

  const BestSellersError({required this.message});
}
