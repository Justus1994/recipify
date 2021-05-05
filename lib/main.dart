import 'package:flutter/material.dart';
import 'package:recipify/pages/Home.dart';
import 'package:recipify/pages/RecipePage.dart';

void main() {
  runApp(Recipify());
}

final routes = {
  '/': (BuildContext context) => Home(),
  '/create-recipe': (BuildContext context) => RecipePage(),
};

class Recipify extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: routes,
    );
  }
}
