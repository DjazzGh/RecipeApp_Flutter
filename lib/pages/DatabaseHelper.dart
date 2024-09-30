import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('recipes.db');
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE recipes(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          ingredients TEXT,
          steps TEXT,
          cookingTime TEXT,
          difficulty INTEGER
        )
      ''');
      },
    );
  }


  Future<void> insertRecipe(Map<String, dynamic> recipe) async {
    final db = await database;
    recipe['ingredients'] = jsonEncode(recipe['ingredients']); // Encode list as JSON
    await db.insert('recipes', recipe);
  }



  Future<List<Map<String, dynamic>>> getRecipes() async {
    final db = await database;
    return await db.query('recipes');
  }
  Future<List<Map<String, dynamic>>> getAllRecipes() async {
    final db = await database;
    return await db.query('recipes');
  }


// Additional methods for update and delete...
}
