import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/cart_provider.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId') ?? 'guest';
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final userOrders =
    userId == null ? [] : cartProvider.getUserOrders(userId!);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
        backgroundColor: Colors.orange,
      ),
      body: userId == null
          ? const Center(child: CircularProgressIndicator())
          : userOrders.isEmpty
          ? const Center(
        child: Text(
          'Belum ada riwayat pesanan untuk akun ini.',
          style: TextStyle(color: Colors.white70),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: userOrders.length,
        itemBuilder: (context, index) {
          final order = userOrders[index];
          final items = order['items'] as List;
          return Card(
            color: Colors.grey[900],
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order['nama'],
                      style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold)),
                  Text(order['tanggal'],
                      style: const TextStyle(color: Colors.white54)),
                  const Divider(color: Colors.white24),
                  ...items.map((item) => Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item['nama']} (x${item['qty']})',
                        style: const TextStyle(
                            color: Colors.white70),
                      ),
                      Text(
                        'Rp ${(item['harga'] * item['qty']).toStringAsFixed(0)}',
                        style: const TextStyle(
                            color: Colors.white70),
                      ),
                    ],
                  )),
                  const SizedBox(height: 8),
                  Text(
                    'Total: Rp ${order['total'].toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
