import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    final username = usernameCtrl.text.trim();
    final password = passwordCtrl.text.trim();

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Login admin hardcode
    if (username == "admin" && password == "admin123") {
      Navigator.pushReplacementNamed(context, "/admin_page");
      return;
    }

    // Login user database
    final result = await userProvider.login(username, password);

    if (result == "ADMIN") {
      Navigator.pushReplacementNamed(context, "/admin_page");
      return;
    }

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result), backgroundColor: Colors.red),
      );
      return;
    }

    await userProvider.loadUserSession();
    Navigator.pushReplacementNamed(context, "/menu");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7EE),

      // ⭐ Semuanya dibuat benar-benar center
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // LOGO
              CircleAvatar(
                radius: 55,
                backgroundColor: Colors.white,
                backgroundImage: const AssetImage(
                  'assets/images/logo_hmds.png',
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Masuk Akun",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              // CARD LOGIN
              Card(
                color: const Color(0xFF1C1B1F),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // USERNAME
                        TextFormField(
                          controller: usernameCtrl,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            prefixIcon: const Icon(Icons.person),
                            filled: true,
                            fillColor: Colors.white12,
                            labelStyle: const TextStyle(color: Colors.white70),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.orangeAccent,
                                width: 2,
                              ),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (v) =>
                          v!.isEmpty ? 'Masukkan username' : null,
                        ),

                        const SizedBox(height: 18),

                        // PASSWORD
                        TextFormField(
                          controller: passwordCtrl,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            filled: true,
                            fillColor: Colors.white12,
                            labelStyle: const TextStyle(color: Colors.white70),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.orangeAccent,
                                width: 2,
                              ),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (v) =>
                          v!.isEmpty ? 'Masukkan password' : null,
                        ),

                        const SizedBox(height: 24),

                        // BUTTON LOGIN
                        ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            "MASUK",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // LINK REGISTER
                        TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, "/register"),
                          child: const Text(
                            "Belum punya akun? Daftar sekarang",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),

                        // LINK ADMIN
                        TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, "/admin_login"),
                          child: const Text(
                            "Login sebagai Admin",
                            style: TextStyle(
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
