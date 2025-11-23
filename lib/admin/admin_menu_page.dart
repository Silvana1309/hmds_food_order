import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminMenuPage extends StatefulWidget {
  const AdminMenuPage({super.key});

  @override
  State<AdminMenuPage> createState() => _AdminMenuPageState();
}

class _AdminMenuPageState extends State<AdminMenuPage> {
  List menu = [];

  Future<void> loadMenu() async {
    final url =
        "https://6921934e512fb4140be0a867.mockapi.io/api/v1/menu";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        menu = jsonDecode(response.body);
      });
    }
  }

  Future<void> deleteMenu(String id) async {
    final url =
        "https://6921934e512fb4140be0a867.mockapi.io/api/v1/menu/$id";
    await http.delete(Uri.parse(url));
    loadMenu();
  }

  @override
  void initState() {
    super.initState();
    loadMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kelola Menu")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: menu.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: menu.length,
        itemBuilder: (context, i) {
          final item = menu[i];
          return Card(
            child: ListTile(
              leading: Image.network(item['image']),
              title: Text(item['name']),
              subtitle: Text("Rp ${item['price']}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => deleteMenu(item['id']),
              ),
            ),
          );
        },
      ),
    );
  }
}