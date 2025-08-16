import 'package:bingo/features/seller-order/data/models/order_model.dart';

import '../../domain/repo/seller_order_repo.dart';
import '../datasource/seller_order_datasource.dart';

class SellerOrdersRepoImpl implements SellerOrderRepo {
  final SellerOrderDatasource sellerOrderDatasource;

  SellerOrdersRepoImpl(this.sellerOrderDatasource);

  @override
  Future<List<ShopOrder>> getRecentOrders({int limit = 5}) async {
    return await sellerOrderDatasource.getRecentOrders(limit: limit);
  }
}
