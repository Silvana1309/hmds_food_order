import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/food_item.dart';

class AdminEditMenuPage extends StatefulWidget {
  final FoodItem food;
  const AdminEditMenuPage({super.key, required this.food});

  @override
  State<AdminEditMenuPage> createState() => _AdminEditMenuPageState();
}

class _AdminEditMenuPageState extends State<AdminEditMenuPage> {
  final String apiBase = 'https://6921934e512fb4140be0a867.mockapi.io/api/v1';
  late TextEditingController nameC;
  late TextEditingController priceC;
  late TextEditingController descC;
  late TextEditingController imageC;

  @override
  void initState() {
    super.initState();
    nameC = TextEditingController(text: widget.food.name);
    priceC = TextEditingController(text: widget.food.price.toString());
    descC = TextEditingController(text: widget.food.description);
    imageC = TextEditingController(text: widget.food.imageUrl);
  }

  Future<void> updateMenu() async {
    final url = Uri.parse('$apiBase/menu/${widget.food.id}');
    final body = {
      'name': nameC.text,
      'price': double.tryParse(priceC.text) ?? 0,
      'description': descC.text,
      'imageUrl': imageC.text,
    };

    try {
      final res = await http.put(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
      if (res.statusCode == 200) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gagal memperbarui menu')));
      }
    } catch (e) {
      debugPrint('updateMenu error: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gagal memperbarui menu')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Menu'), backgroundColor: Colors.orange),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameC, decoration: const InputDecoration(labelText: 'Nama Menu')),
            TextField(controller: priceC, decoration: const InputDecoration(labelText: 'Harga')),
            TextField(controller: descC, decoration: const InputDecoration(labelText: 'Deskripsi')),
            TextField(controller: imageC, decoration: const InputDecoration(labelText: 'Image URL')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: updateMenu, child: const Text('Update')),
          ],
        ),
      ),
    );
  }
}