import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'dresses.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE dresses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      )
    ''');
  }

  Future<void> seedInitialData() async {
    final db = await database;
    final existing = await db.query('dresses');

    if (existing.isEmpty) {
      await insertDress('Lara Croft Tank Top');
      await insertDress('Tight Latex Heelless Shoes');
      await insertDress('One-Shoulder Off Rose Dress');
      await insertDress('Lovey Butt-Ons Heels');
    }
  }

  Future<void> insertDress(String name) async {
    final db = await database;
    await db.insert('dresses', {'name': name});
  }

  Future<List<String>> searchDressesByName(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      'dresses',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );
    return results.map((row) => row['name'] as String).toList();
  }

  Future<List<String>> getAllDressNames() async {
  final db = await database;
  final result = await db.query('dresses');
  return result.map((row) => row['name'] as String).toList();
}

}
