import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/food_item.dart';
import '../models/order_model.dart';
import '../repositories/user_repository.dart';


class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];
  List<Order> get orders => _orders;


  /// ⭐ Tambahkan async agar bisa pakai await
  Future<void> addOrder(
      String userId,
      List<FoodItem> cartItems,
      double total,
      String paymentMethod
      ) async {

    // Simpan di aplikasi
    final newOrder = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      items: cartItems,
      total: total,
      date: DateTime.now(),
      paymentMethod: paymentMethod,
      status: "pending",
    );

    _orders.add(newOrder);
    notifyListeners();

    // 🔥 Kirim pesanan ke API MockAPI agar admin bisa melihatnya
    final url = Uri.parse(
        "https://6921934e512fb4140be0a867.mockapi.io/orders"
    );

    final body = {
      "userId": userId,
      "items": cartItems.map((e) => e.toMap()).toList(),
      "total": total,
      "date": DateTime.now().toIso8601String(),
      "paymentMethod": paymentMethod,
      "status": "pending",
    };

    try {
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        debugPrint("Order berhasil dikirim ke API");
      } else {
        debugPrint("Gagal kirim order: ${res.statusCode}");
      }
    } catch (e) {
      debugPrint("Send order to API error: $e");
    }
  }

  List<Order> getOrdersByUser(String userId) {
    return _orders.where((order) => order.userId == userId).toList();
  }
}