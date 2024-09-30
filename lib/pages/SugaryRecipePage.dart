import 'package:flutter/material.dart';

import 'NextPage.dart';

class SugaryRecipePage extends StatefulWidget {
  const SugaryRecipePage({super.key});

  @override
  _SugaryRecipePageState createState() => _SugaryRecipePageState();
}

class _SugaryRecipePageState extends State<SugaryRecipePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();
  final _timeController = TextEditingController();
  String _timeUnit = 'Minutes';
  int _difficulty = 1;
  List<String> _Saltyingredients = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Dessert',style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),)),
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
              ..._Saltyingredients.map((ingredient) => ListTile(
                title: Text(ingredient),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      _Saltyingredients.remove(ingredient);
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
                          _Saltyingredients.add(_ingredientsController.text);
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Store the values
                    final title = _titleController.text;
                    final ingredients = _Saltyingredients;
                    final cookingTime = '${_timeController.text} $_timeUnit';
                    final difficulty = _difficulty;
                    final steps = _stepsController.text;

                    // You can now use these values as needed
                    print('Title: $title');
                    print('Ingredients: $ingredients');
                    print('Cooking Time: $cookingTime');
                    print('Difficulty: $difficulty stars');
                    print('Steps: $steps');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder:
                        (context) => NextPage()));
                  }
                },

                    child:
                    Text('Validate'),)

            ],
          ),
        ),
      ),
    );
  }
}