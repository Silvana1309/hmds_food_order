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
}
