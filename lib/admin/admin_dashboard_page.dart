import 'package:flutter/material.dart';
import 'admin_menu_page.dart';
import 'admin_orders_page.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Kelola Menu"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AdminMenuPage()),
              );
            },
          ),
          ListTile(
            title: const Text("Riwayat Pesanan User"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AdminOrdersPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}