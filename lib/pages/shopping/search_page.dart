import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Database database;
  List<Map<String, dynamic>> dresses = [];
  String selectedCategory = 'dresses';

  final List<String> categories = ['dresses', 'tops', 'bottoms', 'shoes'];

  @override
  void initState() {
    super.initState();
    initDb();
  }

  Future<void> initDb() async {
    final path = join(await getDatabasesPath(), 'dress_database.db');
    database = await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS dress_info (id INTEGER PRIMARY KEY, name TEXT, type TEXT)',
        );
      },
      version: 1,
    );

    await insertSampleData(); // You can remove this after testing
    loadDressesByType(selectedCategory);
  }

  Future<void> insertSampleData() async {
    final count = Sqflite.firstIntValue(await database.rawQuery('SELECT COUNT(*) FROM dress_info'));
    if (count == 0) {
      await database.insert('dress_info', {'name': 'High and Chic Heels', 'type': 'shoes'});
      await database.insert('dress_info', {'name': 'Cozy Knit Sweater', 'type': 'tops'});
      await database.insert('dress_info', {'name': 'Black Skirt', 'type': 'bottoms'});
      await database.insert('dress_info', {'name': 'Red Dress', 'type': 'dresses'});
    }
  }

  Future<void> loadDressesByType(String type) async {
    final List<Map<String, dynamic>> maps = await database.query(
      'dress_info',
      where: 'type = ?',
      whereArgs: [type],
    );

    setState(() {
      dresses = maps;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedCategory,
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category[0].toUpperCase() + category.substring(1)),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedCategory = value;
                  });
                  loadDressesByType(value);
                }
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dresses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(dresses[index]['name']),
                  subtitle: Text(dresses[index]['type']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
