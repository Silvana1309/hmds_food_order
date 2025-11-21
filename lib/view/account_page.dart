import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/user_provider.dart';
import 'edit_profile_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.currentUser;

    if (user == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text("Tidak ada user login", style: TextStyle(color: Colors.white)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Akun Saya"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // FOTO PROFILE
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey.shade800,
              backgroundImage:
              user.profileImage != null ? NetworkImage(user.profileImage!) : null,
              child: user.profileImage == null
                  ? const Icon(Icons.person, size: 60, color: Colors.white)
                  : null,
            ),

            const SizedBox(height: 16),

            // NAMA
            Text(
              user.name.isNotEmpty ? user.name : user.username,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            // EMAIL
            Text(
              user.email,
              style: const TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 25),

            // KARTU INFO
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade900,
              ),
              child: Column(
                children: [
                  rowItem("User ID", user.id.toString()),
                  rowItem("Username", user.username),
                  rowItem("Email", user.email),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // TOMBOL EDIT PROFIL
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditProfilePage()),
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text("Edit Profil"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // TOMBOL LOGOUT
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: () async {
                  await userProvider.logout();
                  Navigator.pushReplacementNamed(context, "/login");
                },
                icon: const Icon(Icons.logout, color: Colors.orange),
                label: const Text("Keluar", style: TextStyle(color: Colors.orange)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.orange),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
