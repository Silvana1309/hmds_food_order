import 'package:sqflite/sqflite.dart';
import '../database/db_helper.dart';
import '../models/user_model.dart';

class UserRepository {
  final DBHelper _dbHelper = DBHelper();

  Future<int> register(UserModel user) async {
    final db = await _dbHelper.database;
    return await db.insert('users', user.toMap());
  }

  Future<UserModel?> login(String username, String password) async {
    final db = await _dbHelper.database;

    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }

  Future<bool> usernameExists(String username) async {
    final db = await _dbHelper.database;

    final result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    return result.isNotEmpty;
  }

  // 🔥 FIXED — tidak duplikat, cukup satu fungsi ini saja
  Future<UserModel?> getUserById(int id) async {
    final db = await _dbHelper.database;

    final result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }

    return null;
  }

  Future<int> update(UserModel user) async {
    final db = await _dbHelper.database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }
}
