import 'food_item.dart';

class Order {
  final String id;
  final String userId;
  final List<FoodItem> items;
  final double total;
  final DateTime date;
  final String paymentMethod;
  final String status;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
    required this.date,
    required this.paymentMethod,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
      'total': total,
      'date': date.toIso8601String(),
      'paymentMethod': paymentMethod,
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      userId: map['userId'],
      items: (map['items'] as List).map((i) => FoodItem.fromMap(i)).toList(),
      total: (map['total'] as num).toDouble(),
      date: DateTime.parse(map['date']),
      paymentMethod: map['paymentMethod'] ?? '',
      status: map['status'] ?? '',
    );
  }
}

