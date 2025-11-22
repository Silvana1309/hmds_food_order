import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../models/order_model.dart';
import '../repositories/order_repository.dart';

class CartProvider extends ChangeNotifier {
  final List<FoodItem> _items = [];
  final OrderRepository _orderRepo = OrderRepository();

  List<FoodItem> get items => _items;

  /// ➕ Tambah item ke keranjang
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
        note: item.note,
      ));
    }
    notifyListeners();
  }

  /// Tambah/ubah catatan pada item
  void updateNote(String id, String note) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index].note = note;
      notifyListeners();
    }
  }

  /// ➕ Tambah jumlah item
  void increaseQuantity(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index].quantity += 1;
      notifyListeners();
    }
  }

  /// ➖ Kurangi jumlah item
  void decreaseQuantity(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      if (_items[index].quantity > 1) {
        _items[index].quantity -= 1;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  /// ❌ Hapus item berdasarkan ID
  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  /// 💰 Total harga semua item
  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  /// 🧹 Hapus semua isi keranjang
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  /// 🧾 Simpan pesanan ke SQLite
  Future<void> placeOrder(String userId, String paymentMethod) async {
    if (_items.isEmpty) return;

    final orderId = DateTime.now().millisecondsSinceEpoch.toString();

    final order = Order(
      id: orderId,
      userId: userId,
      items: List.from(_items),
      total: totalPrice,
      date: DateTime.now(),
      paymentMethod: paymentMethod,
      status: "Completed", // default
    );

    print("SIMPAN ORDER UNTUK USER ID: $userId");

    await _orderRepo.insertOrder(order);

    clearCart();
    notifyListeners();
  }

  /// 🔍 Ambil riwayat pesanan user dari SQLite
  Future<List<Order>> getUserOrders(String userId) async {
    return await _orderRepo.getOrdersByUserId(userId);
  }
}
