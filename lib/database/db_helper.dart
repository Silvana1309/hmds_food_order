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

    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        // Jika upgrade dari versi lama → tambah kolom baru
        await db.execute("ALTER TABLE order_items ADD COLUMN imageUrl TEXT");
        await db.execute("ALTER TABLE order_items ADD COLUMN category TEXT");
      },
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE orders (
        id TEXT PRIMARY KEY,
        userId TEXT,
        total REAL,
        date TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE order_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        orderId TEXT,
        itemId TEXT,
        name TEXT,
        price REAL,
        qty INTEGER,
        note TEXT,
        imageUrl TEXT,
        category TEXT,
        FOREIGN KEY(orderId) REFERENCES orders(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE cart (
        id TEXT PRIMARY KEY,
        name TEXT,
        price REAL,
        image TEXT,
        quantity INTEGER
      )
    ''');
  }

  Future<void> close() async {
    final db = await database;
    return db.close();
  }
}
