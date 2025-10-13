import 'package:flutter/material.dart';
import 'models/food_item.dart';
import 'pages/menu_page.dart';
import 'provider/cart_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'pages/order_history_page.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Ordering App',
      theme: ThemeData.dark(),
      home: const SplashScreen(), // 🔥 mulai dari SplashScreen

      // 🧭 Tambahkan route di bawah ini
      routes: {
        '/menu': (context) => const MenuPage(),
        '/cart': (context) => const CartPage(),
        '/order_history': (context) => const OrderHistoryPage(),
        '/account': (context) => const AccountPage(),
      },
    );
  }
}

// ===============================================
//               MAIN FUNCTION
// ===============================================
// void main() {
//   runApp(const MyApp());
// }

// ===============================================
//                ROOT APP
// ===============================================
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

@override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Aplikasi Pemesanan Makanan',
    theme: ThemeData(primarySwatch: Colors.orange),
    home: const SplashScreen(),
  );
}
// }

// ===============================================
//                SPLASH SCREEN
// ===============================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // 🔥 Animasi "pulse" (membesar dan mengecil pelan)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('loggedIn') ?? false;

    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    if (loggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()), // ✅ tampilkan menu + bottom bar
      );

  } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7EE),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ===== LOGO HMDS LINGKARAN BERDENYUT =====
            ScaleTransition(
              scale: _scaleAnimation,
              child: CircleAvatar(
                radius: 90, // ukuran logo
                backgroundColor: Colors.white,
                backgroundImage:
                const AssetImage('assets/images/logo_hmds.png'),
                onBackgroundImageError: (_, __) {
                  debugPrint('❌ Logo HMDS tidak ditemukan');
                },
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'HMDS Food Order',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 25),
            const CircularProgressIndicator(color: Colors.orange),
          ],
        ),
      ),
    );
  }
}


// ===============================================
//                  LOGIN PAGE
// ===============================================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  final List<String> randomNames = [
    'Silvana Angel Kurniawan',
    'Merry Novia',
    'Nur Dea Maudyana',
  ];

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      final randomName = (randomNames..shuffle()).first;

      await prefs.setBool('loggedIn', true);
      await prefs.setString('username', usernameCtrl.text);
      await prefs.setString('email', '${usernameCtrl.text}@gmail.com');
      await prefs.setString('displayName', usernameCtrl.text);


      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Masuk Akun',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: usernameCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (v) =>
                      v!.isEmpty ? 'Masukkan username' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: passwordCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                      validator: (v) =>
                      v!.isEmpty ? 'Masukkan password' : null,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: const Text('MASUK'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ===============================================
//                HOME PAGE (MAIN MENU)
// ===============================================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const MenuPage(),
    const OrderHistoryPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        selectedItemColor: Colors.orange,
        items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant),
          label: 'Menu',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Riwayat Pesanan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Akun',
        ),
        ],
      ),
    );
  }
}

// ===============================================
//                 MENU PAGE
// ===============================================
final List<FoodItem> sampleMenu = [
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
    imageUrl: 'https://images.unsplash.com/photo-1556800463-7995dc657249',
  ),
  FoodItem(
    id: 'd2',
    name: 'Teh Tawar Hangat / Es',
    description: 'Pilihan teh tawar hangat atau dingin.',
    price: 7000,
    category: 'Minuman',
    imageUrl: 'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce',
  ),
  FoodItem(
    id: 'd3',
    name: 'Teh Manis Hangat / Es',
    description: 'Teh manis khas HMDS, bisa hangat atau dingin.',
    price: 8000,
    category: 'Minuman',
    imageUrl: 'https://images.unsplash.com/photo-1511920170033-f8396924c348',
  ),
  FoodItem(
    id: 'd4',
    name: 'Liang Teh Hangat / Es',
    description: 'Minuman herbal segar dan menenangkan.',
    price: 10000,
    category: 'Minuman',
    imageUrl: 'https://images.unsplash.com/photo-1590080875839-3c9b93f1d4f5',
  ),
  FoodItem(
    id: 'd5',
    name: 'Lo Han Guo',
    description: 'Minuman herbal khas Asia dengan rasa manis alami.',
    price: 12000,
    category: 'Minuman',
    imageUrl: 'https://images.unsplash.com/photo-1600180758890-6f2720c7444d',
  ),
  FoodItem(
    id: 'd6',
    name: 'Kopi Americano',
    description: 'Kopi hitam dengan cita rasa kuat.',
    price: 15000,
    category: 'Minuman',
    imageUrl: 'https://images.unsplash.com/photo-1509042239860-f550ce710b93',
  ),
  FoodItem(
    id: 'd7',
    name: 'Es Kopi Susu',
    description: 'Kopi susu segar dengan es batu.',
    price: 17000,
    category: 'Minuman',
    imageUrl: 'https://images.unsplash.com/photo-1542444459-db2a0c9e5a1d',
  ),
  FoodItem(
    id: 'd8',
    name: 'Es Batu',
    description: 'Tambahan es batu untuk minuman kamu.',
    price: 3000,
    category: 'Minuman',
    imageUrl: 'https://images.unsplash.com/photo-1557821552-17105176677c',
  ),
  FoodItem(
    id: 'd9',
    name: 'Matcha Latte',
    description: 'Minuman matcha dengan susu lembut.',
    price: 18000,
    category: 'Minuman',
    imageUrl: 'https://images.unsplash.com/photo-1567427018141-0584cfcbf1b8',
  ),
  FoodItem(
    id: 'd10',
    name: 'Lychee Yakult',
    description: 'Minuman segar kombinasi lychee dan yakult.',
    price: 20000,
    category: 'Minuman',
    imageUrl: 'https://images.unsplash.com/photo-1617196034745-9cb885ffa38c',
  ),
];

// ===============================================
//                 CART PAGE
// ===============================================
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = Cart.items;
    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang')),
      body: cart.isEmpty
          ? const Center(child: Text('Keranjang kosong'))
          : ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final item = cart[index];
          return ListTile(
            title: Text(item),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() => Cart.removeItem(item));
              },
            ),
          );
        },
      ),
      bottomNavigationBar: cart.isEmpty
          ? null
          : Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              minimumSize: const Size(double.infinity, 48)),
          onPressed: () {
            Cart.clear();
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Pesanan berhasil dibuat')));
          },
          child: const Text('Bayar Sekarang'),
        ),
      ),
    );
  }
}

// ===============================================
//                 CART STORAGE
// ===============================================
class Cart {
  static final List<String> items = [];

  static void addItem(String item) => items.add(item);
  static void removeItem(String item) => items.remove(item);
  static void clear() => items.clear();
}

// ===============================================
//                 ACCOUNT PAGE
// ===============================================
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String name = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadAccount();
  }

  Future<void> _loadAccount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('displayName') ?? '';
      email = prefs.getString('email') ?? '';
    });
  }

  Future<void> _editProfile() async {
    final nameCtrl = TextEditingController(text: name);
    final emailCtrl = TextEditingController(text: email);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Nama')),
              TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email')),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('displayName', nameCtrl.text);
                await prefs.setString('email', emailCtrl.text);
                setState(() {
                  name = nameCtrl.text;
                  email = emailCtrl.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Akun Saya')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://cdn-icons-png.flaticon.com/512/6997/6997662.png',
              ),
            ),
            const SizedBox(height: 16),
            Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(email, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profil'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: _editProfile,
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Keluar'),
              onPressed: _logout,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                side: const BorderSide(color: Colors.orange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
