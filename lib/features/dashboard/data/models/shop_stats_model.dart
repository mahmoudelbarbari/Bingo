import '../../domain/entity/shop_stats_entity.dart';

class ShopStatsModel {
  final int totalProducts;
  final int activeListings;
  final int ordersToday;
  final int totalRevenue;
  final double conversionRate;
  final double averageRating;

  ShopStatsModel({
    required this.totalProducts,
    required this.activeListings,
    required this.ordersToday,
    required this.totalRevenue,
    required this.conversionRate,
    required this.averageRating,
  });

  factory ShopStatsModel.fromJson(Map<String, dynamic> json) {
    return ShopStatsModel(
      totalProducts: json['totalProducts'],
      activeListings: json['activeListings'],
      ordersToday: json['ordersToday'],
      totalRevenue: json['totalRevenue'],
      conversionRate: json['conversionRate'].toDouble(),
      averageRating: json['averageRating'].toDouble(),
    );
  }

  ShopStatsEntity toEntity() {
    return ShopStatsEntity(
      totalProducts: totalProducts,
      activeListings: activeListings,
      ordersToday: ordersToday,
      totalRevenue: totalRevenue,
      conversionRate: conversionRate,
      averageRating: averageRating,
    );
  }
}
