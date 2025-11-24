import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          "Admin Dashboard",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
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

            const SizedBox(height: 10),

            const Text(
              "Kelola data aplikasi melalui menu berikut:",
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 25),

            // ==============================
            // MENU GRID
            // ==============================
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildMenuItem(
                    icon: Icons.fastfood,
                    title: "Kelola Menu",
                    onTap: () {
                      Navigator.pushNamed(context, "/manage_menu");
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.shopping_cart,
                    title: "Pesanan Masuk",
                    onTap: () {
                      Navigator.pushNamed(context, "/order_history");
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.person,
                    title: "Data User",
                    onTap: () {
                      Navigator.pushNamed(context, "/users");
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.bar_chart,
                    title: "Laporan",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // WIDGET UNTUK KOTAK MENU
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 45, color: Colors.orange),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
