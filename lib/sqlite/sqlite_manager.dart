import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' if (dart.library.io) 'package:sqflite/sqflite.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;




class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  DatabaseFactory getDatabaseFactory() {
    if (kIsWeb) {
      throw UnsupportedError('Web not supported');
    } if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      return databaseFactoryFfi;
    } else {
      return databaseFactory; // mobile
    }
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'dresses.db');

    final factory = getDatabaseFactory();

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
