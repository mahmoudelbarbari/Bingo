// Cubit
import 'package:bingo/features/home/domain/usecase/get_all_categories_usecase.dart';
import 'package:bingo/features/home/presentaion/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/injection_container.dart';

class HomeCubit extends Cubit<CategoriesState> {
  late GetAllCategoriesUsecase getAllCategoriesUsecase;

  HomeCubit() : super(CategoriesInitial());

  Future<void> getCategories() async {
    getAllCategoriesUsecase = sl();
    try {
      emit(CategoriesLoading());
      final categories = await getAllCategoriesUsecase.call();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }
}
