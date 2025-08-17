import 'package:bingo/features/home/domain/repo/home_repo.dart';

import '../../../product/domain/entity/product.dart';

class SearchProductUsecase {
  final HomeRepo _homeRepo;

  SearchProductUsecase(this._homeRepo);

  Future<List<ProductEntity>> call(String query) async =>
      await _homeRepo.searchProduct(query);
}
