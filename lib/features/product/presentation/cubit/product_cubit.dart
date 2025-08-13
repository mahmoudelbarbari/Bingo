import 'package:bingo/features/product/data/models/product_model.dart';
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

  Future<void> createProduct(ProductModel product) async {
    addProductUsecase = sl();
    try {
      emit(ProductLoadingState());
      // Initialize usecase only once in constructor or inject it!
      await addProductUsecase.call(product);
      // You might want to check result here if it is a response or success bool
      emit(ProductAddedSuccess('Product added successfully'));
    } catch (e) {
      emit(ProductCreateError(e.toString()));
    }
  }
}
