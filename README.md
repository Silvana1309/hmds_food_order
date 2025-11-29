# food_order_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



Manual Book Aplikasi HMDS Food Order

Aplikasi HMDS FOOD ini merupakan aplikasi pemesanan makanan yang berbasis flutter 
yang memungkinkan pengguna untuk melihat menu,
menambahkan item ke dalam keranjang belanja, melakukan pemesanan, melihat riwayat transaksi,
mengelola akun, serta menyediakan halaman khusus untuk admin.

Aplikasi ini menggunakan :
-Flutter (Frontend)
-Provider (State Management)
-SQLite (Database lokal)
-Routing Navigation 
-Admin Page (untuk keperluan management data)

Alur Utama Aplikasi :
-Menampilkan Logo Aplikasi HMDS
-Delay 3 detik untuk masuk ke aplikasi
-Mengecek user pernah login/belum:
 *Jika belum login-pindah ke LoginPage
 *Jika sudah login-pindah ke HomePage

Halaman-Halaman Aplikasi :
-Login Page (User):
 *User login untuk masuk ke aplikasi
 *Navigasi ke RegisterPage jika belum memiliki akun

-Register Page:
 *membuat akun baru
 *data disimpan di database (via provider)

-Home Page:
 *Menu-Menampilkan daftar makanan
 *Riwayat-Menampilkan riwayat pesanan
 *Akun-Informasi User + Edit Profil

-Menu Page:
 *Menampilkan list menu makanan
 *Tombol "Add to Cart" untuk memasukkan makanan ke keranjang

-Cart Page:
 *Menampilkan daftar item yang dipilih
 *Mengubah jumlah pesanan
 *Menghapus item
 *Tombol "Pesan Sekarang"

-Order History Page:
 *Menampilkan daftar pesanan sebelumnya
 *Diambil dari OrderProvider

-Edit Profil Page:
 *Mengubah nama, email, atau password user

Halaman Admin :
-Admin Login:
 *Login khusus admin
 *Keamanan terpisah dari user

-Admin Page:
 *Mengelola data menu
 *Melihat daftar transaksi
 *Mengontrol data user(opsional)

Sistem Navigasi (Routing) :
   * /menu             - MenuPage
   * /home             - HomePage 
   * /cart             - CartPage
   * /order_history    - OrderHistoryPage
   * /account          - AccountPage
   * /login            - LoginPage
   * /register         - RegisterPage
   * /edit_profil      - EditProfilPage
   * /admin_page       - AdminPage
   * /admin_login      - AdminLogin

Provider & State Management :
-CartProvider:
 *Menambahkan item ke keranjang
 *Menghapus item
 *Mengubah jumlah
 *Total harga

-OrderProvider:
 *Menyimpan pesanan (order)
 *Riwayat pesanan

-UserProvider:
 *Login
 *Registrasi
 *Edit profil
 *Menyimpan sesi user via SQLite

Alur Login & Sesision Management :
-User login - data disimpan di database lokal (SQLite)
-Saat aplikasi di buka - loadUserSession() dijalankan
-Jika user ditemukan - langsung masuk HomePage
-Jika tidak - masuk LoginPage

Alur Pemesanan (Order Flow)
-User memilih menu
-Tekan "Add to Cart"
-Buka Cart
-Atur jumlah atau hapus menu
-Tekan "Pesan Sekarang"
-OrderProvider menyimpan pesanan
-Muncul Riwayat pesanan di OrderHistoryPage

Bottom Navigation Bar :
-Menu
-Riwayat
-Akun

Database :
-SQLite - menyimpan sesi user
-MockAPI / DB eksternal (menyimpan pesanan)


///////////////////////////////////////////////////////////////////////////////


Main.dart - point utama dari aplikasi untuk bisa berjalan dengan lancar.
Main.dart - menginisialisasi provider, database, halaman utama, routing, splash screen.

Fungsi & Alur kode aplikasi berjalan :

 * struktur utama main.dart
- import library & provider
- fungsi main()
- class MyApp (Root App)
- SplashScreen
- HomePage dengan Bottom Navigation

 * import library & provider :
- menghubungkan class utama dengan halaman-halaman aplikasi
- menggunakan provider untuk state management seperti :
 ~ keranjang belanja (CartProvider)
 ~ riwayat pesanan (OrderProvider)
 ~ user session (UserProvider)
- menggunakan SQLite untuk database lokal

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

 * fungsi main()
- agar Flutter dapat menjalankan fungsi async sebelum runApp
- menghapus database lama (biasanya untuk memperbaiki struktur database)
- Load User Session - mangecek apakah user sudah login sebelumnya
- MultiProvider :
 ~ CartProvider - meyimpan item pesanan
 ~ OrderProvider - mengelola riwayat transaksi
 ~ UserProvider - login, logout, sesi user

 * Root App (MyApp)
- MaterialApp - root widget aplikasi
- tema utama menggunakan warna
- halaman pertama = SplashScreen
- routing disediakan untuk semua halaman :
 ~ menu makanan
 ~ keranjang
 ~ riwayat pesanan
 ~ akun
 ~ login & register
 ~ edit profil

 * SplashScreen
- menampilkan logo selama 2 detik
- mengecek apakah user sudah login
- mengarahkan user ke :
 ~ LoginPage - jika belum login
 ~ HomePage - jika sudah login
- Alur SplashScreen
 ~ Delay 2 detik
 ~ ambil user session dari UserProvider
 ~ arahkan ke halaman sesuai kondisi login

 * HomePage dengan Bottom Navigation
- user dapat berpindah ke :
 ~ Menu 
 ~ Riwayat Pesanan
 ~ Akun
- menggunakan state untuk menentukan halaman yang ditampilkan

 * Flow Aplikasi
1. Aplikasi dibuka - SplashScreen tampil selama 2 detik
2. Mengecek User Login - jika belum login -> ke LoginPage, jika sudah login -> masuk ke HomePage
3. HomPage - tersedia 3 tab : 
    ~ Menu Makanan
    ~ Riwayat Pesanan
    ~ Akun Penggguna

 * Fitur Utama yang Diinisialisasi di main.dart

Fitur - Description
Provider State Management - menyimpan state keranjang, pesanan, user
Splash Screen - menentukan halaman awal aplikasi
Routing - navigasi ke semua halaman aplikasi
Bottom Navigasi - navigasi utama user
Database Reset - menghapus database lama saat startup

