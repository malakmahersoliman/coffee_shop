// lib/database/db_helper.dart
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:coffeetute/models/coffee.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'coffee_shop.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE coffees(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        price REAL,
        imagePath TEXT,
        quantity INTEGER
      )
    ''');
  }


  Future<int> insertCoffee(Coffee coffee) async {
  final db = await database;
  int id = await db.insert(
    'coffees',
    coffee.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  return id;
}

 
  Future<List<Coffee>> getCoffees() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('coffees');
    return List.generate(maps.length, (i) {
      return Coffee(
        name: maps[i]['name'],
        price: maps[i]['price'],
        imagePath: maps[i]['imagePath'],
        quantity: maps[i]['quantity'],
      );
    });
  }

  
  Future<void> updateCoffee(Coffee coffee) async {
    final db = await database;
    await db.update(
      'coffees',
      coffee.toMap(),
      where: 'id = ?',
      whereArgs: [coffee.id],
    );
  }


  Future<void> deleteCoffee(int id) async {
    final db = await database;
    await db.delete(
      'coffees',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}