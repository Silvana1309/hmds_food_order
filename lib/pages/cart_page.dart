import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item.dart';
import '../provider/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<CartProvider>(context).items;
    double total =
    cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        backgroundColor: Colors.redAccent,
      ),
      body: cartItems.isEmpty
          ? const Center(
        child: Text(
          'Keranjang masih kosong',
          style: TextStyle(color: Colors.white),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(item.name,
                      style: const TextStyle(color: Colors.white)),
                  subtitle: Text(
                    '${item.quantity}x - Rp ${item.price.toStringAsFixed(0)}'
                        '\nCatatan: ${item.note ?? "-"}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('Total: Rp ${total.toStringAsFixed(0)}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green),
                  onPressed: () {
                    _showPaymentOptions(context, total);
                  },
                  child: const Text('Bayar Sekarang'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showPaymentOptions(BuildContext context, double total) {
    showModalBottomSheet(
      backgroundColor: Colors.grey[900],
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.credit_card, color: Colors.white),
              title: const Text('Kartu Kredit/Debit',
                  style: TextStyle(color: Colors.white)),
              onTap: () => _showSuccessMessage(context),
            ),
            ListTile(
              leading: const Icon(Icons.money, color: Colors.white),
              title: const Text('Tunai', style: TextStyle(color: Colors.white)),
              onTap: () => _showSuccessMessage(context),
            ),
            ListTile(
              leading: const Icon(Icons.phone_android, color: Colors.white),
              title: const Text('E-Wallet (GoPay / OVO / DANA)',
                  style: TextStyle(color: Colors.white)),
              onTap: () => _showSuccessMessage(context),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessMessage(BuildContext context) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pesanan berhasil! Sedang dalam proses.'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
