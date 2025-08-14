class ShopStatsEntity {
  final int totalProducts;
  final int activeListings;
  final int ordersToday;
  final int totalRevenue;
  final double conversionRate;
  final double averageRating;

  ShopStatsEntity({
    required this.totalProducts,
    required this.activeListings,
    required this.ordersToday,
    required this.totalRevenue,
    required this.conversionRate,
    required this.averageRating,
  });
}
