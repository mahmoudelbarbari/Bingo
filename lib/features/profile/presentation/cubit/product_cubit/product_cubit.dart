import 'package:bingo/features/profile/domain/usecases/get_products_usecase.dart';
import 'package:bingo/features/profile/presentation/cubit/product_cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/injection_container.dart';

class ProductCubit extends Cubit<ProductState> {
  late GetProductsUsecase getProductsUsecase;

  ProductCubit() : super(ProductInitState());

  Future<void> getAllProduct() async {
    try {
      emit(ProductLoadingState());
      getProductsUsecase = sl();
      final allProducts = await getProductsUsecase.call();
      emit(ProductLoadedState(productEntity: allProducts));
    } catch (e) {
      emit(ProductErrorState(errorMessage: e.toString()));
    }
  }
}
