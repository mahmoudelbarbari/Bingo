import 'package:bingo/features/product/domain/entity/product.dart';
import 'package:bingo/features/product/domain/usecase/add_product_usecase.dart';
import 'package:bingo/features/product/domain/usecase/get_products_usecase.dart';
import 'package:bingo/features/product/presentation/cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/injection_container.dart';

class ProductCubit extends Cubit<ProductState> {
  late GetProductsUsecase getProductsUsecase;
  late AddProductUsecase addProductUsecase;

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

  Future<void> createProduct(ProductEntity product) async {
    try {
      emit(ProductLoadingState());
      addProductUsecase = sl();
      await addProductUsecase.call(product);
      emit(ProductAddedSuccess('Product added successfuly'));
    } catch (e) {
      emit(ProductCreateError(e.toString()));
    }
  }
}
