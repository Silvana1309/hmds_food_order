import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text('Profil Pengguna',
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }
}
