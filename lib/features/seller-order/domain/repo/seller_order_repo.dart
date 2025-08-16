import '../../data/models/order_model.dart';

abstract class SellerOrderRepo {
  Future<List<ShopOrder>> getRecentOrders({int limit = 5});
}
