import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import 'view_model/cart_provider.dart';
import 'view_model/order_provider.dart';
import 'view_model/user_provider.dart';

// Pages
import 'view/menu_page.dart';
import 'view/cart_page.dart';
import 'view/account_page.dart';
import 'view/order_history_page.dart';
import 'view/login_page.dart';
import 'view/register_page.dart';



// ==================================================
//                     MAIN
// ==================================================
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userProvider = UserProvider();
  await userProvider.loadUserSession();   // 🔥 ambil session dari SQLite

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => userProvider),  // 🔥 ini wajib
      ],
      child: const MyApp(),
    ),
  );
}


// ==================================================
//                     ROOT APP
// ==================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Ordering App',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const SplashScreen(),
      routes: {
        '/menu': (context) => const MenuPage(),
        '/cart': (context) => const CartPage(),
        '/order_history': (context) => const OrderHistoryPage(),
        '/account': (context) => const AccountPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(), // 🔥 WAJIB
      },
    );
  }
}


// ==================================================
//                   SPLASH SCREEN
// ==================================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    await Future.delayed(const Duration(seconds: 2));

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => userProvider.currentUser == null
            ? const LoginPage()
            : const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FlutterLogo(size: 120),
      ),
    );
  }
}


// ==================================================
//                    HOME PAGE
// ==================================================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final pages = [
    const MenuPage(),
    const OrderHistoryPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.orange,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: "Menu"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Riwayat"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Akun"),
        ],
      ),
    );
  }
}
