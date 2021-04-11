import 'package:flutter/material.dart';

class Recipes extends StatefulWidget {
  Recipes({Key key}) : super(key: key);

  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Recipes"),
      ),
    );
  }
}
