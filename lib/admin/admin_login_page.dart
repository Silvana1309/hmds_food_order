// import 'package:flutter/material.dart';
//
// class AdminLoginPage extends StatefulWidget {
//   const AdminLoginPage({super.key});
//
//   @override
//   State<AdminLoginPage> createState() => _AdminLoginPageState();
// }
//
// class _AdminLoginPageState extends State<AdminLoginPage> {
//   final TextEditingController userController = TextEditingController();
//   final TextEditingController passController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xfff8f4f0),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(25),
//           child: Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(18),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 8,
//                   offset: Offset(0, 3),
//                 )
//               ],
//             ),
//             width: 330,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   "Login Admin",
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 TextField(
//                   controller: userController,
//                   decoration: const InputDecoration(
//                     labelText: "Username Admin",
//                     prefixIcon: Icon(Icons.person),
//                   ),
//                 ),
//
//                 const SizedBox(height: 12),
//
//                 TextField(
//                   controller: passController,
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     labelText: "Password",
//                     prefixIcon: Icon(Icons.lock),
//                   ),
//                 ),
//
//                 const SizedBox(height: 25),
//
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                     minimumSize: const Size(double.infinity, 45),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   onPressed: () {
//                     _handleAdminLogin();
//                   },
//                   child: const Text(
//                     "MASUK ADMIN",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _handleAdminLogin() {
//     const adminUser = "admin";
//     const adminPass = "123456";
//
//     if (userController.text == adminUser &&
//         passController.text == adminPass) {
//       Navigator.pushReplacementNamed(context, "/admin_page");
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Username atau Password Admin Salah!"),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
// }




















import 'package:flutter/material.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f4f0),

      // ==========================
      // APPBAR DENGAN TOMBOL BACK
      // ==========================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 120, // agar ruang untuk icon + tulisan cukup
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Row(
              children: const [
                Icon(Icons.arrow_back, color: Colors.black, size: 28),
                SizedBox(width: 6),
                Text(
                  "Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                )
              ],
            ),
            width: 330,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Login Admin",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: userController,
                  decoration: const InputDecoration(
                    labelText: "Username Admin",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),

                const SizedBox(height: 25),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    _handleAdminLogin();
                  },
                  child: const Text(
                    "MASUK ADMIN",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleAdminLogin() {
    const adminUser = "admin";
    const adminPass = "123456";

    if (userController.text == adminUser &&
        passController.text == adminPass) {
      Navigator.pushReplacementNamed(context, "/admin_page");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Username atau Password Admin Salah!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
