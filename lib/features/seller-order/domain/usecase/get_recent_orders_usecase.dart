import 'package:bingo/features/seller-order/domain/repo/seller_order_repo.dart';

import '../../data/models/order_model.dart';

class GetRecentOrdersUsecase {
  final SellerOrderRepo _sellerOrderRepo;

  GetRecentOrdersUsecase(this._sellerOrderRepo);

  Future<List<ShopOrder>> call({int limit = 5}) async =>
      _sellerOrderRepo.getRecentOrders(limit: limit);
}
