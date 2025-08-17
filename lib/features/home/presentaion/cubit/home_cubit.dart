import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/injection_container.dart';
import '../../../product/domain/entity/product.dart';
import '../../data/models/category_model.dart.dart';
import '../../domain/usecase/get_all_categories_usecase.dart';
import '../../domain/usecase/get_three_prodcut_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  late GetAllCategoriesUsecase getAllCategoriesUsecase;
  late GetThreeProdcutUsecase getThreeProdcutUsecase;

  List<ProductEntity> _cachedProducts = [];
  CategoryModel? _cachedCategories;
  bool _categoriesLoading = false;

  HomeCubit() : super(HomeInitial());

  Future<void> getCategories() async {
    if (_categoriesLoading) return; // Prevent duplicate calls
    _categoriesLoading = true;

    getAllCategoriesUsecase = sl();
    try {
      emit(CategoriesLoading());
      _cachedCategories = await getAllCategoriesUsecase.call();
      emit(CategoriesLoaded(_cachedCategories!));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    } finally {
      _categoriesLoading = false;
    }
  }

  Future<void> getThreeProducts() async {
    getThreeProdcutUsecase = sl();
    try {
      emit(ThreeProductsLoading());
      _cachedProducts = await getThreeProdcutUsecase.call();
      emit(ThreeProductsLoaded(_cachedProducts));
    } catch (e) {
      emit(ThreeProductsError(e.toString()));
    }
  }
}
