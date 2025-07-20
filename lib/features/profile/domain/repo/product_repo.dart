import 'package:bingo/features/profile/domain/entity/product.dart';

abstract class ProductRepo {
  Future<List<ProductEntity>> getAllProduct();
}
