import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/food_item.dart';
import 'admin_add_menu_page.dart';
import 'admin_edit_menu_page.dart';

class AdminMenuPage extends StatefulWidget {
  const AdminMenuPage({super.key});

  @override
  State<AdminMenuPage> createState() => _AdminMenuPageState();
}

class _AdminMenuPageState extends State<AdminMenuPage> {
  final String apiBase = 'https://6921934e512fb4140be0a867.mockapi.io/api/v1';
  late Future<List<FoodItem>> _future;

  @override
  void initState() {
    super.initState();
    _future = fetchMenu();
  }

  Future<List<FoodItem>> fetchMenu() async {
    final url = Uri.parse('$apiBase/menu');
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        return data.map((e) => FoodItem.fromMap(e)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('fetchMenu error: $e');
      return [];
    }
  }

  Future<void> deleteMenu(String id) async {
    final url = Uri.parse('$apiBase/menu/$id');
    try {
      final res = await http.delete(url);
      if (res.statusCode == 200 || res.statusCode == 204) {
        setState(() => _future = fetchMenu());
      }
    } catch (e) {
      debugPrint('deleteMenu error: $e');
    }
  }

  Future<void> refresh() async => setState(() => _future = fetchMenu());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Menu'), backgroundColor: Colors.orange),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminAddMenuPage()));
          refresh();
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<FoodItem>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (!snap.hasData || snap.data!.isEmpty) return const Center(child: Text('Belum ada menu.'));
          final list = snap.data!;
          return RefreshIndicator(
            onRefresh: refresh,
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: list.length,
              itemBuilder: (context, i) {
                final f = list[i];
                return Card(
                  color: Colors.grey[900],
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: f.imageUrl.isNotEmpty ? Image.network(f.imageUrl, width: 60, height: 60, fit: BoxFit.cover) : null,
                    title: Text(f.name, style: const TextStyle(color: Colors.white)),
                    subtitle: Text('Rp ${f.price.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white70)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () async {
                            await Navigator.push(context, MaterialPageRoute(builder: (_) => AdminEditMenuPage(food: f)));
                            refresh();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteMenu(f.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}