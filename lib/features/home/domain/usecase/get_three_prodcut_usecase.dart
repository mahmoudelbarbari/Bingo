import 'package:bingo/features/home/domain/repo/home_repo.dart';

import '../../../product/domain/entity/product.dart';

class GetThreeProdcutUsecase {
  final HomeRepo _homeRepo;

  GetThreeProdcutUsecase(this._homeRepo);

  Future<List<ProductEntity>> call() async => await _homeRepo.getThreeProduct();
}
