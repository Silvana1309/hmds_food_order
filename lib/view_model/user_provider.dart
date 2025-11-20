import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';
import '../database/db_helper.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepo = UserRepository();

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  // REGISTER
  Future<String?> register(
      String username, String password, String name, String email) async {

    try {
      final exists = await _userRepo.usernameExists(username);
      if (exists) return "Username sudah digunakan!";

      final user = UserModel(
        username: username,
        password: password,
        name: name,
        email: email,
      );

      await _userRepo.register(user);
      return null;
    } catch (e) {
      return "Gagal mendaftar!";
    }
  }


  // LOGIN
  Future<String?> login(String username, String password) async {
    final user = await _userRepo.login(username, password);

    if (user == null) return "Username atau password salah!";

    _currentUser = user;

    final db = DBHelper();
    await db.saveSession(user.id!);

    notifyListeners();
    return null;
  }

  // LOGOUT
  Future<void> logout() async {
    final db = DBHelper();
    await db.clearSession();

    _currentUser = null;
    notifyListeners();
  }

  // LOAD session saat app dibuka
  Future<void> loadUserSession() async {
    final db = DBHelper();
    final userId = await db.getSessionUserId();

    if (userId == null) {
      _currentUser = null;
      notifyListeners();
      return;
    }

    // Ambil data user dari DB
    final user = await _userRepo.getUserById(userId);

    _currentUser = user;
    notifyListeners();
  }
}
