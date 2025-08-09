import 'package:bingo/features/product/domain/usecase/get_seller_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/injection_container.dart';
import 'seller_products_state.dart';

class SellerProductsCubit extends Cubit<SellerProductsState> {
  late GetSellerProductsUsecase getSellerProductsUsecase;

  SellerProductsCubit() : super(SellerProductsInitialState());

  Future<void> getSellerProducts() async {
    try {
      emit(SellerProductsLoadingState());
      getSellerProductsUsecase = sl();
      final products = await getSellerProductsUsecase.call();
      emit(SellerProductsLoadedState(products: products));
    } catch (e) {
      emit(SellerProductsErrorState(errorMessage: e.toString()));
    }
  }
}
