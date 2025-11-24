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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Selamat Datang, Admin",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text("Kelola data aplikasi melalui menu berikut:"),
            const SizedBox(height: 20),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  // 🔶 Kelola Menu
                  _buildMenuBox(
                    context,
                    icon: Icons.restaurant_menu,
                    label: "Kelola Menu",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AdminMenuPage()),
                      );
                    },
                  ),

                  // 🔶 Pesanan Masuk (Riwayat Pesanan User)
                  _buildMenuBox(
                    context,
                    icon: Icons.shopping_cart,
                    label: "Pesanan Masuk",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AdminOrdersPage()),
                      );
                    },
                  ),

                  // 🔶 Data User (belum dibuat, opsional)
                  _buildMenuBox(
                    context,
                    icon: Icons.person,
                    label: "Data User",
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Fitur Data User belum dibuat")),
                      );
                    },
                  ),

                  // 🔶 Laporan (opsional)
                  _buildMenuBox(
                    context,
                    icon: Icons.bar_chart,
                    label: "Laporan",
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Fitur Laporan belum dibuat")),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔧 BOX BUILDER
  Widget _buildMenuBox(BuildContext context,
      {required IconData icon,
        required String label,
        required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.orange, size: 45),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
