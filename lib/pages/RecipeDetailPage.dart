import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'DatabaseHelper.dart';

// Import DatabaseHelper

class RecipeDetailPage extends StatefulWidget {
  final String title;

  const RecipeDetailPage({super.key, required this.title});

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage>
{
List<String> ingredients = [];
String cookingTime = '';
int difficulty = 0;
String steps = '';

final databaseHelper = DatabaseHelper(); // Initialize DatabaseHelper

@override
void initState() {
super.initState();
_fetchRecipeDetails();
}

Future<void> _fetchRecipeDetails() async {
  final db = await databaseHelper.database;
  final List<Map<String, dynamic>> maps = await db.query(
    'recipes',
    where: 'title = ?',
    whereArgs: [widget.title],
  );

  if (maps.isNotEmpty) {
    final Map<String, dynamic> recipe = maps[0];
    try {
      // Attempt to decode JSON string

      if (recipe['ingredients'] is List) {
        setState(() {
          ingredients = List<String>.from(recipe['ingredients']); // Convert to list
          cookingTime = recipe['cookingTime'];
          difficulty = recipe['difficulty'];
          steps = recipe['steps'];
        });
      } else {
        print("Error: ingredients is not a List");
      }
    } on FormatException catch (e) {
      // Handle potential format exceptions during decoding
      print("Error decoding ingredients: $e");
    }
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Ingredients:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...ingredients.map((ingredient) => Text(ingredient)),
            SizedBox(height: 16),
            Text('Cooking Time: $cookingTime', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text('Difficulty: ${'⭐' * difficulty}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text('Steps:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(steps),
          ],
        ),
      ),
    );
  }
}
