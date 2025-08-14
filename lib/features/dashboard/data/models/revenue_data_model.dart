import '../../domain/entity/revenue_data_entity.dart';

class RevenueDataModel {
  final String id;
  final String color;
  final List<RevenuePointModel> data;

  RevenueDataModel({required this.id, required this.color, required this.data});

  factory RevenueDataModel.fromJson(Map<String, dynamic> json) {
    return RevenueDataModel(
      id: json['id'],
      color: json['color'],
      data: List<RevenuePointModel>.from(
        json['data'].map((x) => RevenuePointModel.fromJson(x)),
      ),
    );
  }

  // Add toEntity method
  RevenueDataEntity toEntity() {
    return RevenueDataEntity(
      id: id,
      color: color,
      data: data.map((point) => point.toEntity()).toList(),
    );
  }
}

class RevenuePointModel {
  final String x;
  final int y;

  RevenuePointModel({required this.x, required this.y});

  factory RevenuePointModel.fromJson(Map<String, dynamic> json) {
    return RevenuePointModel(x: json['x'], y: json['y']);
  }

  // Add toEntity method
  RevenuePointEntity toEntity() {
    return RevenuePointEntity(date: x, amount: y);
  }
}
