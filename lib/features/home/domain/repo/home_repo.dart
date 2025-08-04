import 'package:bingo/features/home/data/models/category_model.dart.dart';

abstract class HomeRepo {
  Future<CategoryModel> getCategories();
}
