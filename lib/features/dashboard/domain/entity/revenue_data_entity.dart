class RevenueDataEntity {
  final String id;
  final String color;
  final List<RevenuePointEntity> data;

  RevenueDataEntity({
    required this.id,
    required this.color,
    required this.data,
  });
}

class RevenuePointEntity {
  final String date;
  final int amount;

  RevenuePointEntity({required this.date, required this.amount});
}
