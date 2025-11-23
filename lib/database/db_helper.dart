import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB('hmds_db.db');
    return _db!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    print("DB PATH: $path"); // Tambahkan ini untuk debug

    return await openDatabase(
      path,
      version: 5,
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        try {
          if (oldVersion < 5) {
            final columns = await db.rawQuery("PRAGMA table_info(users)");

            final hasName = columns.any((c) => c['name'] == 'name');
            final hasEmail = columns.any((c) => c['name'] == 'email');
            final hasProfile = columns.any((c) => c['name'] == 'profile_image');

            if (!hasName) {
              await db.execute("ALTER TABLE users ADD COLUMN name TEXT");
            }
            if (!hasEmail) {
              await db.execute("ALTER TABLE users ADD COLUMN email TEXT");
            }
            if (!hasProfile) {
              await db.execute("ALTER TABLE users ADD COLUMN profile_image TEXT");
            }
          }
        } catch (e) {
          print("UPGRADE ERROR: $e");
        }
      },
    );
  }


  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT,
      password TEXT,
      name TEXT,
      email TEXT,
      profile_image TEXT
    )
  ''');

    await db.execute('''
    CREATE TABLE session(
      userId INTEGER
    )
  ''');

    await db.execute('''
    CREATE TABLE orders(
      id TEXT PRIMARY KEY,
      userId TEXT,
      total REAL,
      date TEXT,
      paymentMethod TEXT,
      status TEXT
    )
  ''');

    await db.execute('''
    CREATE TABLE order_items(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      orderId TEXT,
      itemId TEXT,
      name TEXT,
      price REAL,
      qty INTEGER,
      note TEXT,
      imageUrl TEXT,
      category TEXT
    )
  ''');

    await db.insert('users', {
      'username': 'admin',
      'password': 'admin123',
      'name': 'Administrator',
      'email': 'admin@hmds.com',
      'role': 'admin',
    });
  }

  // ====================
  // SESSION
  // ====================
  Future<void> saveSession(int userId) async {
    final db = await database;
    await db.delete("session");
    await db.insert("session", {"userId": userId});
  }

  Future<int?> getSessionUserId() async {
    final db = await database;
    final result = await db.query("session");
    if (result.isEmpty) return null;
    return result.first["userId"] as int;
  }

  Future<void> clearSession() async {
    final db = await database;
    await db.delete("session");
  }
}