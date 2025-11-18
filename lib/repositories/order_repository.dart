import 'package:sqflite/sqflite.dart';
import '../database/db_helper.dart';
import '../models/order_model.dart';
import '../models/food_item.dart';

class OrderRepository {
  final DBHelper _dbHelper = DBHelper();

  /// INSERT order baru ke SQLite
  Future<int> insertOrder(Order order) async {
    final db = await _dbHelper.database;

    // Simpan order utama
    await db.insert('orders', {
      'id': order.id,
      'userId': order.userId,
      'total': order.total,
      'date': order.date.toIso8601String(),
    });

    // Simpan item-item dalam order
    for (var item in order.items) {
      await db.insert('order_items', {
        'orderId': order.id,
        'itemId': item.id,
        'name': item.name,
        'price': item.price,
        'qty': item.quantity,
        'note': item.note ?? '',
        'imageUrl': item.imageUrl,
        'category': item.category,
      });
    }

    return 1;
  }

  /// Ambil order berdasarkan userId
  Future<List<Order>> getOrdersByUserId(String userId) async {
    final db = await _dbHelper.database;

    final orderRows = await db.query(
      'orders',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: "date DESC",
    );

    List<Order> orders = [];

    for (var orderMap in orderRows) {
      // Ambil semua items dari order_id ini
      final itemRows = await db.query(
        'order_items',
        where: 'orderId = ?',
        whereArgs: [orderMap['id']],
      );

      List<FoodItem> items = itemRows.map((item) {
        return FoodItem(
          id: item['itemId'] as String,
          name: item['name'] as String,
          description: '', // boleh dikosongkan kalau memang tidak disimpan
          price: (item['price'] as num).toDouble(),
          imageUrl: item['imageUrl'] as String,
          category: item['category'] as String,
          quantity: item['qty'] as int,
          note: item['note'] as String?,
        );
      }).toList();

      orders.add(
        Order(
          id: orderMap['id'] as String,
          userId: orderMap['userId'] as String,
          items: items,
          total: (orderMap['total'] as num).toDouble(),
          date: DateTime.parse(orderMap['date'] as String),
        ),
      );
    }

    return orders;
  }
}
