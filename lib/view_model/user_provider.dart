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

    // ⭐ LOGIN ADMIN MANUAL
    if (username == "admin" && password == "admin123") {
      return "ADMIN";
    }

    // 🔥 LOGIN USER BIASA
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
    try {
      final db = DBHelper();
      final userId = await db.getSessionUserId();

      if (userId == null) {
        _currentUser = null;
        notifyListeners();
        return;
      }

      final user = await _userRepo.getUserById(userId);

      _currentUser = user;
      notifyListeners();
    } catch (e) {
      print("LOAD SESSION ERROR: $e");
      _currentUser = null;
      notifyListeners();
    }
  }

  // UPDATE PROFILE
  Future<String?> updateProfile({
    required int userId,
    String? username,
    String? name,
    String? email,
    String? password,
    String? profileImage,
  }) async {
    try {
      // Ambil user sekarang
      final current = _currentUser ?? await _userRepo.getUserById(userId);
      if (current == null) return "User tidak ditemukan";

      // Buat user baru dengan data yang diperbarui
      final updated = UserModel(
        id: current.id,
        username: username ?? current.username,
        password: password ?? current.password,
        name: name ?? current.name,
        email: email ?? current.email,
        profileImage: profileImage ?? current.profileImage,
      );

      // update ke database
      await _userRepo.update(updated);

      // refresh data di provider
      _currentUser = await _userRepo.getUserById(userId);
      notifyListeners();
      return null;
    } catch (e) {
      return "Gagal memperbarui profil";
    }
  }
}