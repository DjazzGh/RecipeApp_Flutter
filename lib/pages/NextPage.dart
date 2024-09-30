import 'package:flutter/material.dart';
import 'package:untitled/pages/RecipeDetailPage.dart';
import 'NewRecipePage.dart';
import 'DatabaseHelper.dart';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  Future<List<Map<String, dynamic>>> _fetchRecipes() async {
    final dbHelper = DatabaseHelper();
    return await dbHelper.getAllRecipes();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        title: Text(
        'Recipes',
        style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 28,
    ),
    ),
    centerTitle: true,
    backgroundColor: Colors.deepOrange,
    ),

    body: Stack(
    children: [
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Container(
    margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
    decoration: BoxDecoration(
    boxShadow: [
    BoxShadow(
    color: Color(0xff1D1617).withOpacity(0.11),
    blurRadius: 50,
    spreadRadius: 0,
    ),
    ],
    ),

    child: TextField(
    decoration: InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: 'Search Pasta',
    hintStyle: const TextStyle(
    color: Colors.white54,
    fontSize: 25,
    ),
    contentPadding: EdgeInsets.all(15),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide.none,
    ),
    icon: const Icon(Icons.search_rounded),
    ),
    ),
    ),
    Container(
        margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
    child: Text('List of Recipes', style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold))),
    Padding(
    padding: const EdgeInsets.all(16.0),
    child: ListView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    children: [

    Text('Titles of Recipes:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    FutureBuilder<List<Map<String, dynamic>>>(
    future: _fetchRecipes(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return CircularProgressIndicator();
    } else if (snapshot.hasError) {
    return Text('Error: ${snapshot.error}');
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    return Text('No recipes found', style: TextStyle(color: Colors.grey));
    } else {
    final recipes = snapshot.data!;
    return Column(
    children: recipes.map((recipe) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RecipeDetailPage(title: recipe['title'])),
        );

      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        color: Colors.cyan,
        width: 200,
        height: 50.0,
        child: Center(
          child: Text(
            recipe['title'],
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );

    }).toList(),
    );
    }
    },
    ),
    ],
    ),
    ),
    ],
    ),
    Positioned(
    bottom: 20.0,
    right: 20.0, child: FloatingActionButton( onPressed: () { Navigator.push( context, MaterialPageRoute( builder: (context) => NewRecipePage(), ), ); }, child: Icon(Icons.add, color: Colors.white), backgroundColor: Colors.deepOrange, ), ), ], ), ); } }