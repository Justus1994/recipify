import 'package:flutter/material.dart';
import 'package:recipify/db/RecipifyDB.dart';

import 'dart:io';

import 'package:recipify/model/Recipe.dart';

class Recipes extends StatefulWidget {
  Recipes({Key? key}) : super(key: key);

  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {

  var recipes = <Recipe>[];

  @override
  void initState() {
    RecipifyDB.db.getRecipes().then((value) => {
      setState(() {
        recipes = value;
      })
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RawMaterialButton(
        child: Text('add Recipe'),
        onPressed: fabOnPress,
      ),
      body: ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final recipe = recipes[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: Dismissible(
                background: Container(
                  color: Colors.red,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.delete),
                    ),
                  )
                ),
                secondaryBackground: Container(
                    color: Colors.blue,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.edit),
                      )
                    ),
                ),
                key: Key('key'),
                onDismissed: (direction) {
                  setState(() {
                  });
                },
                child: ListTile(
                  title: Text('${recipe.name}'),
                  subtitle: Text('Kcal ${recipe.energy}'),
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundImage: MemoryImage(recipe.image),
                    radius: 30,
                    // FileImage(File(recipe.image)) : null,
                  ),
                ),
              ),
            );
          },
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fabOnPress() async {
    final result = await Navigator.of(context).pushNamed('/create-recipe') as Recipe;
    print(result.toString());
    RecipifyDB.db.insertRecipe(result);
    setState(() {
    });
  }
}
