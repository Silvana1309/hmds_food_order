import 'package:flutter/material.dart';
import '../models/food_item.dart';

class CartProvider extends ChangeNotifier {
  final List<FoodItem> _items = [];
  final List<Map<String, dynamic>> _orderHistory = [];

  List<FoodItem> get items => _items;
  List<Map<String, dynamic>> get orderHistory => _orderHistory;

  void addItem(FoodItem item) {
    final index = _items.indexWhere((element) => element.id == item.id);
    if (index >= 0) {
      _items[index].quantity += 1;
    } else {
      _items.add(FoodItem(
        id: item.id,
        name: item.name,
        description: item.description,
        price: item.price,
        imageUrl: item.imageUrl,
        category: item.category,
        quantity: 1,
      ));
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  /// 🧾 Simpan pesanan ke riwayat dan kosongkan keranjang
  void placeOrder() {
    if (_items.isEmpty) return;

    _orderHistory.add({
      'nama': 'Pesanan ${_orderHistory.length + 1}',
      'tanggal': DateTime.now().toString().substring(0, 16),
      'total': totalPrice,
      'items': _items
          .map((e) => {
        'nama': e.name,
        'qty': e.quantity,
        'harga': e.price,
      })
          .toList(),
    });

    clearCart(); // kosongkan keranjang setelah checkout
    notifyListeners();
  }
}
