import 'package:sqflite/sqflite.dart';
import '../database/db_helper.dart';
import '../models/food_item.dart';

class CartRepository {
  final DBHelper _dbHelper = DBHelper();

  // INSERT item ke cart
  Future<int> addToCart(FoodItem item) async {
    final db = await _dbHelper.database;

    return await db.insert(
      'cart',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // GET semua item cart
  Future<List<FoodItem>> getCartItems() async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> data = await db.query('cart');

    return data.map((e) => FoodItem.fromMap(e)).toList();
  }

  // HAPUS item tertentu
  Future<int> removeItem(String id) async {
    final db = await _dbHelper.database;

    return await db.delete(
      'cart',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // HAPUS semua cart (checkout)
  Future<int> clearCart() async {
    final db = await _dbHelper.database;
    return await db.delete('cart');
  }

  // UPDATE quantity
  Future<int> updateQuantity(String id, int quantity) async {
    final db = await _dbHelper.database;

    return await db.update(
      'cart',
      {'quantity': quantity},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
