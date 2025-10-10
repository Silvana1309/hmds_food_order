import 'package:flutter/material.dart';
import '../models/food_item.dart';

class CartProvider extends ChangeNotifier {
  final List<FoodItem> _items = [];

  List<FoodItem> get items => _items;

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
}
