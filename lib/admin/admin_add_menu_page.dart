import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/food_item.dart';

class AdminAddMenuPage extends StatefulWidget {
  const AdminAddMenuPage({super.key});

  @override
  State<AdminAddMenuPage> createState() => _AdminAddMenuPageState();
}

class _AdminAddMenuPageState extends State<AdminAddMenuPage> {
  final String apiBase = 'https://6921934e512fb4140be0a867.mockapi.io/api/v1';
  final TextEditingController nameC = TextEditingController();
  final TextEditingController priceC = TextEditingController();
  final TextEditingController descC = TextEditingController();
  final TextEditingController imageC = TextEditingController();

  Future<void> addMenu() async {
    final url = Uri.parse('$apiBase/menu');
    final body = {
      'name': nameC.text,
      'price': double.tryParse(priceC.text) ?? 0,
      'description': descC.text,
      'imageUrl': imageC.text,
    };

    try {
      final res = await http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
      if (res.statusCode == 201 || res.statusCode == 200) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gagal menambah menu')));
      }
    } catch (e) {
      debugPrint('addMenu error: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gagal menambah menu')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Menu'), backgroundColor: Colors.orange),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameC, decoration: const InputDecoration(labelText: 'Nama Menu')),
            TextField(controller: priceC, decoration: const InputDecoration(labelText: 'Harga')),
            TextField(controller: descC, decoration: const InputDecoration(labelText: 'Deskripsi')),
            TextField(controller: imageC, decoration: const InputDecoration(labelText: 'Image URL')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: addMenu, child: const Text('Simpan')),
          ],
        ),
      ),
    );
  }
}