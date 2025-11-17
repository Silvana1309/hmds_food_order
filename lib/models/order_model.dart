import 'food_item.dart';

class Order {
  final String id;
  final String userId;
  final List<FoodItem> items;
  final double total;
  final DateTime date;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
      'total': total,
      'date': date.toIso8601String(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      userId: map['userId'],
      items: (map['items'] as List).map((i) => FoodItem.fromMap(i)).toList(),
      total: (map['total'] as num).toDouble(),
      date: DateTime.parse(map['date']),
    );
  }
}