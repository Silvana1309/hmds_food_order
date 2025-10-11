import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy sementara — nanti bisa diambil dari provider/Firestore
    final orders = [
      {'nama': 'Nasi Goreng Spesial', 'tanggal': '10 Okt 2025', 'total': 25000},
      {'nama': 'Mie Alami', 'tanggal': '09 Okt 2025', 'total': 23000},
      {'nama': 'Nasi Kuning Bahagia', 'tanggal': '08 Okt 2025', 'total': 25000},
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: ListView.builder(
        itemCount: orders.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.receipt_long, color: Colors.orangeAccent),
              title: Text(
                order['nama'].toString(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                order['tanggal'].toString(),
                style: const TextStyle(color: Colors.white70),
              ),
              trailing: Text(
                'Rp ${order['total'].toString()}',
                style: const TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
