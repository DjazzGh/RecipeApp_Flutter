import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';
import 'NextPage.dart';

class SaltyRecipePage extends StatefulWidget {
  const SaltyRecipePage({super.key});

  @override
  _SaltyRecipePageState createState() => _SaltyRecipePageState();
}

class _SaltyRecipePageState extends State<SaltyRecipePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();
  final _timeController = TextEditingController();
  String _timeUnit = 'Minutes';
  int _difficulty = 1;
  List<String> _ingredients = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Dish')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title of the Recipe'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the title of the recipe';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text('Ingredients'),
              ..._ingredients.map((ingredient) => ListTile(
                title: Text(ingredient),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      _ingredients.remove(ingredient);
                    });
                  },
                ),
              )),
              TextFormField(
                controller: _ingredientsController,
                decoration: InputDecoration(
                  labelText: 'Add Ingredient',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (_ingredientsController.text.isNotEmpty) {
                        setState(() {
                          _ingredients.add(_ingredientsController.text);
                          _ingredientsController.clear();
                        });
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text('Cooking Time'),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _timeController,
                      decoration: InputDecoration(labelText: 'Enter Time'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the cooking time';
                        }
                        final intValue = int.tryParse(value);
                        if (intValue == null || intValue <= 0) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  DropdownButton<String>(
                    value: _timeUnit,
                    items: ['Minutes', 'Hours']
                        .map((unit) => DropdownMenuItem(
                      value: unit,
                      child: Text(unit),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _timeUnit = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _stepsController,
                decoration: InputDecoration(labelText: 'Steps'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the steps';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text('Difficulty'),
              DropdownButtonFormField<int>(
                value: _difficulty,
                items: List.generate(5, (index) => index + 1)
                    .map((difficulty) => DropdownMenuItem(
                  value: difficulty,
                  child: Row(
                    children: List.generate(
                        difficulty, (index) => Icon(Icons.star)),
                  ),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _difficulty = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final title = _titleController.text;
                    final ingredients = _ingredients.join(', ');
                    final cookingTime = '${_timeController.text} $_timeUnit';
                    final difficulty = _difficulty;
                    final steps = _stepsController.text;

                    final recipe = {
                      'title': title,
                      'ingredients': ingredients,
                      'cookingTime': cookingTime,
                      'difficulty': difficulty,
                      'steps': steps,
                    };

                    final dbHelper = DatabaseHelper();
                    try {
                      await dbHelper.insertRecipe(recipe);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const NextPage()),
                      ); // Navigate back to NextPage with a success flag
                    } catch (e) {
                      // Handle the error (e.g., show a snackbar or alert)
                      print('Error inserting recipe: $e');
                    }
                  }
    },
                child: Text('Validate'),
              )

            ],
          ),
        ),
      ),
    );
  }
}
