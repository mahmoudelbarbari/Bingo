import 'package:bingo/config/injection_container.dart';
import 'package:bingo/features/shops/domain/entity/shop_entity.dart';
import 'package:bingo/features/shops/domain/usecase/get_best_sellers_shops_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'best_sellers_state.dart';

class BestSellersCubit extends Cubit<BestSellersState> {
  late GetBestSellersShopsUsecase getBestSellersShopsUsecase;

  BestSellersCubit() : super(BestSellersInitial());

  Future<void> getBestSellers() async {
    emit(BestSellersLoading());
    getBestSellersShopsUsecase = sl();
    try {
      final shops = await getBestSellersShopsUsecase.call();
      emit(BestSellersLoaded(shops: shops));
    } catch (e) {
      emit(BestSellersError(message: e.toString()));
    }
  }
}
