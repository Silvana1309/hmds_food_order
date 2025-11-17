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
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart(
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        price REAL,
        category TEXT,
        imageUrl TEXT,
        quantity INTEGER,
        note TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE orders(
        id TEXT PRIMARY KEY,
        date TEXT,
        total REAL
      )
    ''');
    await db.execute('''
      CREATE TABLE order_items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_id TEXT,
        food_id TEXT,
        name TEXT,
        price REAL,
        quantity INTEGER,
        FOREIGN KEY(order_id) REFERENCES orders(id)
      )
    ''');
  }

  Future<void> close() async {
    final db = await database;
    return db.close();
  }
}