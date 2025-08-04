import 'package:bingo/features/home/data/models/category_model.dart.dart';
import 'package:bingo/features/home/domain/repo/home_repo.dart';

class GetAllCategoriesUsecase {
  final HomeRepo homeRepo;

  GetAllCategoriesUsecase(this.homeRepo);

  Future<CategoryModel> call() async => await homeRepo.getCategories();
}
