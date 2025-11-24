import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

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
import 'view/edit_profile_page.dart';

import 'pages/admin_page.dart';
import 'admin/admin_login_page.dart';


// ==================================================
//                     MAIN
// ==================================================
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userProvider = UserProvider();
  await userProvider.loadUserSession();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => userProvider),
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
        "/home": (context) => const HomePage(),
        '/cart': (context) => const CartPage(),
        '/order_history': (context) => const OrderHistoryPage(),
        '/account': (context) => const AccountPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/edit_profile': (context) => const EditProfilePage(),
        "/admin_page": (_) => const AdminPage(),
        "/admin_login": (context) => const AdminLoginPage(),
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

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();

    _startApp();
  }

  Future<void> _startApp() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final userProvider = Provider.of<UserProvider>(context, listen: false);

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _opacity,
          child: Image.asset(
            'assets/images/logo_hmds.png',
            width: 150,
          ),
        ),
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
