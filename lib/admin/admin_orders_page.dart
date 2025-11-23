import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminOrdersPage extends StatefulWidget {
  const AdminOrdersPage({super.key});

  @override
  State<AdminOrdersPage> createState() => _AdminOrdersPageState();
}

class _AdminOrdersPageState extends State<AdminOrdersPage> {
  List orders = [];

  Future<void> loadOrders() async {
    final url = "https://6921934e512fb4140be0a867.mockapi.io/api/v1/orders";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        orders = jsonDecode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Riwayat Pesanan")),
      body: orders.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, i) {
          final order = orders[i];
          return Card(
            child: ListTile(
              title: Text("User ID: ${order['userId']}"),
              subtitle: Text("Total: ${order['total']}"),
              trailing:
              Text(order['paymentMethod'] ?? "Unknown"),
            ),
          );
        },
      ),
    );
  }
}