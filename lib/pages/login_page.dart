import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'menu_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  // Fungsi login sederhana
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final username = usernameCtrl.text.trim();
      final password = passwordCtrl.text.trim();

      if (username == 'admin' && password == '1234') {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('displayName', 'Admin HMDS');
        await prefs.setString('email', 'admin@hmds.com');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MenuPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username atau Password salah!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7EE),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              color: const Color(0xFF1C1B1F),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 24),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                        ),
                        child: const Text('Login'),
                      ),
                      const SizedBox(height: 24),


      // ===== LOGO HMDS LINGKARAN =====
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: const AssetImage(
                          'assets/images/logo_hmds.png',
                        ),
                        onBackgroundImageError: (error, stackTrace) {
                          debugPrint('❌ Logo HMDS tidak ditemukan di assets/images/');
                        },
                      ),
                      const SizedBox(height: 20),

                      // ===== TEKS MASUK AKUN =====
                      const Text(
                        'Masuk Akun',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ===== USERNAME =====
                      TextFormField(
                        controller: usernameCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.person),
                          filled: true,
                          fillColor: Colors.white10,
                          labelStyle: TextStyle(color: Colors.white70),
                        ),
                        style: const TextStyle(color: Colors.white),
                        validator: (v) =>
                        v!.isEmpty ? 'Masukkan username' : null,
                      ),
                      const SizedBox(height: 12),

                      // ===== PASSWORD =====
                      TextFormField(
                        controller: passwordCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          filled: true,
                          fillColor: Colors.white10,
                          labelStyle: TextStyle(color: Colors.white70),
                        ),
                        style: const TextStyle(color: Colors.white),
                        obscureText: true,
                        validator: (v) =>
                        v!.isEmpty ? 'Masukkan password' : null,
                      ),
                      const SizedBox(height: 24),

                      // ===== TOMBOL MASUK =====
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'MASUK',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
