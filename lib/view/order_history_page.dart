import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/cart_provider.dart';
import '../models/order_model.dart';
import '../view_model/user_provider.dart';


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
    // AMBIL USER ID DARI CART PROVIDER
    final userProvider =
    Provider.of<UserProvider>(context, listen: false);

    setState(() {
      userId = userProvider.currentUser?.id.toString() ?? "guest";
    });

    print("📌 ORDER HISTORY MEMINTA USER ID: $userId");
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
        backgroundColor: Colors.orange,
      ),
      body: userId == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<List<Order>>(
        future: cartProvider.getUserOrders(userId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada riwayat pesanan untuk akun ini.',
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          final orders = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final items = order.items;

              return Card(
                color: Colors.grey[900],
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order ID: ${order.id}",
                        style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        order.date.toString(),
                        style: const TextStyle(color: Colors.white54),
                      ),
                      const Divider(color: Colors.white24),
                      ...items.map(
                            (item) => Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${item.name} (x${item.quantity})',
                              style: const TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              'Rp ${(item.price * item.quantity).toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Total: Rp ${order.total.toStringAsFixed(0)}',
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
          );
        },
      ),
    );
  }
}
