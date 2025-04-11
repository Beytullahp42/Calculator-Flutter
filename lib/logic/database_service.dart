import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/calculation.dart';

// I took references from the following link: (thanks)
// https://github.com/thisissandipp/flutter-sqflite-example

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  factory DatabaseService() => instance;

  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('calculator.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''CREATE TABLE calculations (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      calculation TEXT NOT NULL,
      result TEXT NOT NULL,
      date TEXT NOT NULL
    )''');
  }

  Future<void> insert(Calculation calculation) async {
    final db = await instance.database;

    await db.insert(
      'calculations',
      calculation.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Calculation>> getCalculations() async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query('calculations');

    return List.generate(maps.length, (i) {
      return Calculation(
        id: maps[i]['id'],
        calculation: maps[i]['calculation'],
        result: maps[i]['result'],
        date: DateTime.parse(maps[i]['date']),
      );
    });
  }

  Future<void> deleteAll() async {
    final db = await instance.database;
    await db.delete('calculations');
  }
}
