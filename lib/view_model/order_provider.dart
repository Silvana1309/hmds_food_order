import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../models/order_model.dart';

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => _orders;

  // Tambah pesanan baru
  void addOrder(
      String userId,
      List<FoodItem> cartItems,
      double total,
      String paymentMethod,   // ⬅ tambahkan
      ) {
    final newOrder = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      items: cartItems,
      total: total,
      date: DateTime.now(),

      paymentMethod: paymentMethod,     // ⬅ ISI !
      status: "pending",               // ⬅ default status
    );

    _orders.add(newOrder);
    notifyListeners();
  }


  // Ambil pesanan sesuai user
  List<Order> getOrdersByUser(String userId) {
    return _orders.where((order) => order.userId == userId).toList();
  }
}
