class ShopOrder {
  final String id;
  final String customerName;
  final double total;
  final String status;
  final DateTime createdAt;
  final List<OrderItem> items;

  ShopOrder({
    required this.id,
    required this.customerName,
    required this.total,
    required this.status,
    required this.createdAt,
    required this.items,
  });

  factory ShopOrder.fromJson(Map<String, dynamic> json) {
    return ShopOrder(
      id: json['id'],
      customerName: json['customerName'] ?? 'Anonymous',
      total: (json['total'] as num?)?.toDouble() ?? 0,
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      items: (json['items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
    );
  }

  String get formattedDate {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }

  int get totalQuantity {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }
}

class OrderItem {
  final String name;
  final int quantity;
  final double price;

  OrderItem({required this.name, required this.quantity, required this.price});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      name: json['name'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
    );
  }
}
