import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order_model.dart';
import 'package:provider/provider.dart';
import '../view_model/order_provider.dart';


class AdminOrdersPage extends StatefulWidget {
  const AdminOrdersPage({super.key});

  @override
  State<AdminOrdersPage> createState() => _AdminOrdersPageState();
}

class _AdminOrdersPageState extends State<AdminOrdersPage> {

  Future<List<Order>> fetchAllOrders() async {
    const url = "https://6921934e512fb4140be0a867.mockapi.io/orders";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((e) => Order.fromMap(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error load orders: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesanan Masuk"),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<List<Order>>(
        future: fetchAllOrders(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Belum ada pesanan masuk"),
            );
          }

          final orders = snapshot.data!;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];

              return Card(
                margin: const EdgeInsets.all(12),
                child: ListTile(
                  title: Text("Order ID: ${order.id}"),
                  subtitle: Text(
                    "User: ${order.userId}\n"
                        "Total: Rp ${order.total.toStringAsFixed(0)}\n"
                        "Metode: ${order.paymentMethod}\n"
                        "Status: ${order.status}",
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (val) async {
                      final url = Uri.parse(
                        'https://6921934e512fb4140be0a867.mockapi.io/orders/${order.id}',
                      );

                      final res = await http.put(
                        url,
                        headers: {'Content-Type': 'application/json'},
                        body: jsonEncode({'status': val}),
                      );

                      if (res.statusCode == 200) {
                        setState(() {}); // refresh halaman admin
                      }
                    },
                    itemBuilder: (_) => [
                      const PopupMenuItem(
                          value: 'pending', child: Text('Set Pending')),
                      const PopupMenuItem(
                          value: 'completed', child: Text('Set Completed')),
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
