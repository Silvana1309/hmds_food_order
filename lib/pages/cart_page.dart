import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/food_item.dart';
import '../provider/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;
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
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      )
          : SafeArea(
        child: Column(
          children: [
            // 🔹 Daftar Item Keranjang
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    color: Colors.grey[900],
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔸 Nama & Hapus
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  item.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.redAccent),
                                onPressed: () {
                                  cartProvider.removeItem(item.id);
                                },
                              ),
                            ],
                          ),

                          // 🔸 Harga
                          Text(
                            'Rp ${item.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 14),
                          ),

                          const SizedBox(height: 8),

                          // 🔸 Catatan (editable)
                          TextField(
                            style:
                            const TextStyle(color: Colors.white70),
                            cursorColor: Colors.redAccent,
                            decoration: InputDecoration(
                              labelText: 'Catatan',
                              labelStyle: const TextStyle(
                                  color: Colors.white54, fontSize: 13),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white24),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            controller: TextEditingController(
                                text: item.note ?? ''),
                            onChanged: (value) {
                              cartProvider.updateNote(item.id, value);
                            },
                          ),

                          const SizedBox(height: 12),

                          // 🔸 Tombol + dan -
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle,
                                        color: Colors.redAccent),
                                    onPressed: () {
                                      cartProvider
                                          .decreaseQuantity(item.id);
                                    },
                                  ),
                                  Text(
                                    '${item.quantity}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle,
                                        color: Colors.greenAccent),
                                    onPressed: () {
                                      cartProvider
                                          .increaseQuantity(item.id);
                                    },
                                  ),
                                ],
                              ),
                              Text(
                                'Subtotal: Rp ${(item.price * item.quantity).toStringAsFixed(0)}',
                                style: const TextStyle(
                                    color: Colors.white70),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // 🔹 Bagian Total & Tombol Bayar
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              decoration: const BoxDecoration(
                color: Color(0xFF1A1A1A),
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Pembayaran',
                        style: TextStyle(
                            color: Colors.white70, fontSize: 16),
                      ),
                      Text(
                        'Rp ${total.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding:
                        const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        _showPaymentOptions(
                            context, cartProvider, total);
                      },
                      icon: const Icon(Icons.payment,
                          color: Colors.white),
                      label: const Text(
                        'Bayar Sekarang',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔸 Tampilkan Pilihan Pembayaran
  void _showPaymentOptions(
      BuildContext context, CartProvider cartProvider, double total) {
    showModalBottomSheet(
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.credit_card, color: Colors.white),
              title: const Text(
                'Kartu Kredit/Debit',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => _handlePayment(context, cartProvider),
            ),
            ListTile(
              leading: const Icon(Icons.money, color: Colors.white),
              title: const Text('Tunai',
                  style: TextStyle(color: Colors.white)),
              onTap: () => _handlePayment(context, cartProvider),
            ),
            ListTile(
              leading:
              const Icon(Icons.phone_android, color: Colors.white),
              title: const Text(
                'E-Wallet (GoPay / OVO / DANA)',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => _handlePayment(context, cartProvider),
            ),
          ],
        );
      },
    );
  }

  // 🔸 Tangani Pembayaran (dengan user login)
  Future<void> _handlePayment(
      BuildContext context, CartProvider cartProvider) async {
    Navigator.pop(context);

    if (cartProvider.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Keranjang kosong, tidak bisa memproses pesanan!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // ✅ Ambil userId dari SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? 'guest';

    // ✅ Simpan pesanan ke riwayat sesuai akun login
    cartProvider.placeOrder(userId);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pesanan berhasil! Disimpan ke Riwayat Pesanan.'),
        backgroundColor: Colors.green,
      ),
    );

    // ✅ Arahkan ke halaman Riwayat Pesanan
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushNamed(context, '/order_history');
    });
  }
}
