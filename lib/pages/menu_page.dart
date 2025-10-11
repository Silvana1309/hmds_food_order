import 'package:flutter/material.dart';
import '../models/food_item.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import 'cart_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final List<FoodItem> menu = [
    // ---------------- Non-Vegetarian ----------------
    FoodItem(
      id: 'nv1',
      name: 'Nasi Goreng',
      description: 'Nasi goreng dengan bumbu spesial dan telur mata sapi.',
      price: 25000,
      category: 'Non-Vegetarian',
      imageUrl: 'assets/images/non_vegetarian/nasigoreng.jpeg',
    ),
    FoodItem(
      id: 'nv2',
      name: 'Mie Sinyemek',
      description: 'Mie goreng basah dengan cita rasa gurih pedas.',
      price: 23000,
      category: 'Non-Vegetarian',
      imageUrl: 'assets/images/non_vegetarian/mie_sinyemek.jpeg',
    ),
    FoodItem(
      id: 'nv3',
      name: 'Nasi Ayam Teriyaki',
      description: 'Ayam teriyaki lembut disajikan dengan nasi hangat.',
      price: 30000,
      category: 'Non-Vegetarian',
      imageUrl: 'assets/images/non_vegetarian/teriyaki.jpeg',
    ),
    FoodItem(
      id: 'nv4',
      name: 'Nasi Ayam Barbeque',
      description: 'Ayam panggang dengan saus barbeque khas HMDS.',
      price: 32000,
      category: 'Non-Vegetarian',
      imageUrl: 'assets/images/non_vegetarian/bbq.jpeg',
    ),
    FoodItem(
      id: 'nv5',
      name: 'Nasi Ayam Asam Manis',
      description: 'Ayam goreng krispi dengan saus asam manis segar.',
      price: 29000,
      category: 'Non-Vegetarian',
      imageUrl: 'assets/images/non_vegetarian/asam-manis.jpeg',
    ),
    FoodItem(
      id: 'nv6',
      name: 'Nasi Ayam Bulgogi',
      description: 'Ayam berbumbu manis gurih ala Korea.',
      price: 32000,
      category: 'Non-Vegetarian',
      imageUrl: 'assets/images/non_vegetarian/bulgogi.jpeg',
    ),
    FoodItem(
      id: 'nv7',
      name: 'Silpasta',
      description: 'Pasta lembut dengan saus creamy khas HMDS.',
      price: 27000,
      category: 'Non-Vegetarian',
      imageUrl: 'assets/images/non_vegetarian/silpasta.jpeg',
    ),

    // ---------------- Vegetarian ----------------
    FoodItem(
      id: 'v1',
      name: 'Alami Hemat',
      description: 'Paket hemat dengan bahan alami segar.',
      price: 20000,
      category: 'Vegetarian',
      imageUrl: 'assets/images/vegetarian/alamihemat.jpeg',
    ),
    FoodItem(
      id: 'v2',
      name: 'Alami Berkah',
      description: 'Menu sehat dengan kombinasi sayur dan tempe organik.',
      price: 25000,
      category: 'Vegetarian',
      imageUrl: 'assets/images/vegetarian/alamiberkah.jpeg',
    ),
    FoodItem(
      id: 'v3',
      name: 'Alami Mini',
      description: 'Versi mini dari menu alami untuk porsi ringan.',
      price: 18000,
      category: 'Vegetarian',
      imageUrl: 'assets/images/vegetarian/alamimini.jpeg',
    ),
    FoodItem(
      id: 'v4',
      name: 'Mie Alami',
      description: 'Mie sayuran dengan bumbu tradisional khas HMDS.',
      price: 23000,
      category: 'Vegetarian',
      imageUrl: 'assets/images/vegetarian/miealami.jpeg',
    ),
    FoodItem(
      id: 'v5',
      name: 'Mie Salad',
      description: 'Kombinasi mie dingin dan sayur segar dengan dressing sehat.',
      price: 24000,
      category: 'Vegetarian',
      imageUrl: 'assets/images/vegetarian/miesalad.jpeg',
    ),
    FoodItem(
      id: 'v6',
      name: 'Nasi Kuning Bahagia',
      description: 'Nasi kuning khas HMDS dengan lauk vegetarian.',
      price: 25000,
      category: 'Vegetarian',
      imageUrl: 'assets/images/vegetarian/naskunbahagia.jpeg',
    ),
    FoodItem(
      id: 'v7',
      name: 'Nasi Kuning Berlimpah',
      description: 'Paket lengkap nasi kuning dengan porsi besar.',
      price: 28000,
      category: 'Vegetarian',
      imageUrl: 'assets/images/vegetarian/naskunberlimpah.jpeg',
    ),
    FoodItem(
      id: 'v8',
      name: 'Nasi Kuning Hemat',
      description: 'Pilihan ekonomis untuk pecinta nasi kuning.',
      price: 20000,
      category: 'Vegetarian',
      imageUrl: 'assets/images/vegetarian/naskunhemat.jpeg',
    ),
    FoodItem(
      id: 'v9',
      name: 'Nasi Kuning Mini',
      description: 'Nasi kuning porsi kecil tapi tetap lezat.',
      price: 18000,
      category: 'Vegetarian',
      imageUrl: 'assets/images/vegetarian/naskunmini.jpeg',
    ),

    // ---------------- Minuman ----------------
    FoodItem(
      id: 'd1',
      name: 'Air Mineral',
      description: 'Air mineral segar.',
      price: 5000,
      category: 'Minuman',
      imageUrl: 'assets/images/minuman/air_mineral.jpeg',
    ),
    FoodItem(
      id: 'd2',
      name: 'Teh Tawar Hangat / Es',
      description: 'Pilihan teh tawar hangat atau dingin.',
      price: 7000,
      category: 'Minuman',
      imageUrl: 'assets/images/minuman/teh.jpeg',
    ),
    FoodItem(
      id: 'd3',
      name: 'Teh Manis Hangat / Es',
      description: 'Teh manis khas HMDS, bisa hangat atau dingin.',
      price: 8000,
      category: 'Minuman',
      imageUrl: 'assets/images/minuman/teh_manis.jpeg',
    ),
    FoodItem(
      id: 'd4',
      name: 'Liang Teh Hangat / Es',
      description: 'Minuman herbal segar dan menenangkan.',
      price: 10000,
      category: 'Minuman',
      imageUrl: 'assets/images/minuman/liang teh.jpeg',
    ),
    FoodItem(
      id: 'd5',
      name: 'Lo Han Guo',
      description: 'Minuman herbal khas Asia dengan rasa manis alami.',
      price: 12000,
      category: 'Minuman',
      imageUrl: 'assets/images/minuman/lo-han-guo.jpeg',
    ),
    FoodItem(
      id: 'd6',
      name: 'Kopi Americano',
      description: 'Kopi hitam dengan cita rasa kuat.',
      price: 15000,
      category: 'Minuman',
      imageUrl: 'assets/images/minuman/americano.jpeg',
    ),
    FoodItem(
      id: 'd7',
      name: 'Es Kopi Susu',
      description: 'Kopi susu segar dengan es batu.',
      price: 17000,
      category: 'Minuman',
      imageUrl: 'assets/images/minuman/kopi_susu.jpeg',
    ),
    FoodItem(
      id: 'd8',
      name: 'Es Batu',
      description: 'Tambahan es batu untuk minuman kamu.',
      price: 3000,
      category: 'Minuman',
      imageUrl: 'assets/images/minuman/es_batu.jpeg',
    ),
    FoodItem(
      id: 'd9',
      name: 'Matcha Latte',
      description: 'Minuman matcha dengan susu lembut.',
      price: 18000,
      category: 'Minuman',
      imageUrl: 'assets/images/minuman/matcha-latte.jpeg',
    ),
    FoodItem(
      id: 'd10',
      name: 'Lychee Yakult',
      description: 'Minuman segar kombinasi lychee dan yakult.',
      price: 20000,
      category: 'Minuman',
      imageUrl: 'assets/images/minuman/lychee yakult.jpeg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final nonVeg = menu.where((i) => i.category == 'Non-Vegetarian').toList();
    final veg = menu.where((i) => i.category == 'Vegetarian').toList();
    final drinks = menu.where((i) => i.category == 'Minuman').toList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Menu Makanan'),
          backgroundColor: Colors.redAccent,
          actions: [
            Consumer<CartProvider>(
              builder: (context, cart, _) {
                return Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (
                              context) => const CartPage()),
                        );
                      },
                    ),
                    if (cart.items.isNotEmpty)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.orangeAccent,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            cart.items.length.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: [
              Tab(text: '🍗Non-Vegetarian'),
              Tab(text: '🥦Vegetarian'),
              Tab(text: '🧃Minuman'),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        body: TabBarView(
          children: [
            _buildCategorySection(context, nonVeg),
            _buildCategorySection(context, veg),
            _buildCategorySection(context, drinks),
          ],
        ),
      ),
    );
  }

  // ✅ Tampilkan daftar makanan untuk setiap kategori
  Widget _buildCategorySection(BuildContext context, List<FoodItem> items) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final food = items[index];
        return Card(
          color: Colors.grey[900],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 8),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                food.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              food.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            subtitle: Text(
              food.description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                height: 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Rp ${food.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  IconButton(
                    icon: const Icon(
                        Icons.add_circle, color: Colors.orangeAccent),
                    iconSize: 22,
                    padding: EdgeInsets.zero,
                    onPressed: () => _showCustomizationSheet(context, food),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// 🔥 Fitur kostumisasi sebelum ditambahkan ke keranjang
  void _showCustomizationSheet(BuildContext context, FoodItem food) {
    int quantity = 1;
    TextEditingController noteController = TextEditingController();

    showModalBottomSheet(
      isScrollControlled: true, // ✅ biar sheet bisa menyesuaikan tinggi layar
      backgroundColor: Colors.grey[900],
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          // tinggi awal 60%
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom + 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    food.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: noteController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Catatan (misal: tanpa pedas)',
                      hintStyle: TextStyle(color: Colors.white54),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white30),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          if (quantity > 1) {
                            quantity--;
                            (context as Element)
                                .markNeedsBuild(); // update tampilan
                          }
                        },
                      ),
                      Text(
                        '$quantity',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          quantity++;
                          (context as Element).markNeedsBuild();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      minimumSize: const Size(double.infinity, 45),
                    ),
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('Tambah ke Keranjang'),
                    onPressed: () {
                      final newItem = FoodItem(
                        id: food.id,
                        name: food.name,
                        description: food.description,
                        price: food.price,
                        category: food.category,
                        imageUrl: food.imageUrl,
                        quantity: quantity,
                        note: noteController.text,
                      );
                      Provider.of<CartProvider>(context, listen: false)
                          .addItem(newItem);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '${food.name} ditambahkan ke keranjang'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}