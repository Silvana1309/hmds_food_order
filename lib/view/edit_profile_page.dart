import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/user_provider.dart';
import '../models/user_model.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameCtrl;
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _passwordCtrl;
  String? _profileImage;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).currentUser;
    _usernameCtrl = TextEditingController(text: user?.username ?? '');
    _nameCtrl = TextEditingController(text: user?.name ?? '');
    _emailCtrl = TextEditingController(text: user?.email ?? '');
    _passwordCtrl = TextEditingController();
    _profileImage = user?.profileImage;
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User tidak ditemukan')),
      );
      return;
    }

    final err = await userProvider.updateProfile(
      userId: user.id!,
      username: _usernameCtrl.text.trim(),
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      password: _passwordCtrl.text.isEmpty ? null : _passwordCtrl.text,
      profileImage: _profileImage,
    );

    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(err), backgroundColor: Colors.red),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil berhasil diperbarui')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Profil image (simple circle)
              GestureDetector(
                onTap: () {
                  // Untuk sekarang kita tidak implement upload.
                  // Bisa ditambahkan pakai image_picker dan simpan path/base64.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Upload foto belum diimplementasikan')),
                  );
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                  _profileImage != null ? NetworkImage(_profileImage!) : null,
                  child: _profileImage == null ? const Icon(Icons.person, size: 48) : null,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _usernameCtrl,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (v) => v!.isEmpty ? 'Masukkan username' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Nama lengkap'),
                validator: (v) => v!.isEmpty ? 'Masukkan nama' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) => v!.isEmpty ? 'Masukkan email' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordCtrl,
                decoration: const InputDecoration(labelText: 'Password Baru (opsional)'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text('Simpan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
