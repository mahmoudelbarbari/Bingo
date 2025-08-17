import 'package:bingo/features/home/data/models/category_model.dart.dart';

import '../../../product/domain/entity/product.dart';

abstract class HomeRepo {
  Future<CategoryModel> getCategories();
  Future<List<ProductEntity>> getThreeProduct();
  Future<List<ProductEntity>> searchProduct(String query);
 }
