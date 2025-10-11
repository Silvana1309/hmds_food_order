import 'package:flutter/material.dart';
import '../models/food_item.dart';

class CartProvider extends ChangeNotifier {
  final List<FoodItem> _items = [];
  final List<Map<String, dynamic>> _orderHistory = [];

  List<FoodItem> get items => _items;
  List<Map<String, dynamic>> get orderHistory => _orderHistory;

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
        note: item.note, // ✅ Simpan catatan jika ada
      ));
    }
    notifyListeners();
  }

  /// 🗒️ Tambah / ubah catatan pada item
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

  /// 🧾 Simpan pesanan ke riwayat sesuai user login
  void placeOrder(String userId) {
    if (_items.isEmpty) return;

    // 🔒 Pastikan pesanan disimpan hanya untuk user tertentu
    _orderHistory.add({
      'userId': userId, // ✅ Wajib untuk filter per akun
      'nama': 'Pesanan ${_orderHistory.length + 1}',
      'tanggal': DateTime.now().toString().substring(0, 16),
      'total': totalPrice,
      'items': _items
          .map((e) => {
        'nama': e.name,
        'qty': e.quantity,
        'harga': e.price,
        'catatan': e.note ?? '-', // ✅ Simpan catatan
      })
          .toList(),
    });

    clearCart(); // Kosongkan keranjang setelah checkout
    notifyListeners();
  }

  /// 🔍 Ambil riwayat pesanan berdasarkan userId
  List<Map<String, dynamic>> getUserOrders(String userId) {
    // Filter hanya pesanan milik user yang sedang login
    return _orderHistory.where((order) => order['userId'] == userId).toList();
  }

  /// 🧹 Bersihkan semua riwayat pesanan (opsional, admin only)
  void clearOrderHistory() {
    _orderHistory.clear();
    notifyListeners();
  }
}
