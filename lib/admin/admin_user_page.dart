import 'package:flutter/material.dart';
import '../../database/db_helper.dart';
import '../../models/user_model.dart';

class AdminUserPage extends StatefulWidget {
  const AdminUserPage({super.key});

  @override
  State<AdminUserPage> createState() => _AdminUserPageState();
}

class _AdminUserPageState extends State<AdminUserPage> {
  final DBHelper _db = DBHelper();
  List<UserModel> _users = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() => _loading = true);

    try {
      final db = await _db.database;
      final rows = await db.query('users', orderBy: 'id DESC');

      final list = rows.map((r) {
        // map fields from db to UserModel. adapt if your column names differ
        return UserModel(
          id: r['id'] as int?,
          username: r['username'] as String? ?? '',
          password: r['password'] as String? ?? '',
          name: r['name'] as String? ?? '',
          email: r['email'] as String? ?? '',
          profileImage: r['profile_image'] as String?,
          role: r['role'] as String? ?? 'user',
        );
      }).toList();

      setState(() {
        _users = list;
        _loading = false;
      });
    } catch (e) {
      debugPrint('Load users error: $e');
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gagal memuat data user')));
    }
  }

  Future<void> _deleteUser(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus User'),
        content: const Text('Yakin ingin menghapus user ini?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Batal')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Hapus', style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      final db = await _db.database;
      await db.delete('users', where: 'id = ?', whereArgs: [id]);
      await _loadUsers();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User dihapus')));
    } catch (e) {
      debugPrint('Delete user error: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gagal menghapus user')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data User'),
        backgroundColor: Colors.orange,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _users.isEmpty
          ? const Center(child: Text('Belum ada user terdaftar'))
          : RefreshIndicator(
        onRefresh: _loadUsers,
        child: ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: _users.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final u = _users[i];
            return Card(
              color: Colors.grey[900],
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white12,
                  backgroundImage: u.profileImage != null && u.profileImage!.isNotEmpty
                      ? NetworkImage(u.profileImage!)
                      : null,
                  child: (u.profileImage == null || u.profileImage!.isEmpty) ? const Icon(Icons.person, color: Colors.white) : null,
                ),
                title: Text(u.name, style: const TextStyle(color: Colors.white)),
                subtitle: Text('${u.username}\n${u.email}', style: const TextStyle(color: Colors.white70)),
                isThreeLine: true,
                trailing: PopupMenuButton<String>(
                  onSelected: (val) {
                    if (val == 'delete' && u.id != null) _deleteUser(u.id!);
                  },
                  itemBuilder: (_) => [
                    const PopupMenuItem(value: 'delete', child: Text('Hapus', style: TextStyle(color: Colors.red))),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
