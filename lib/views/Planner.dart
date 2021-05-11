import 'dart:developer';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipify/db/RecipifyDB.dart';
import 'package:recipify/model/Recipe.dart';


class Planner extends StatefulWidget {
  Planner({Key? key}) : super(key: key);

  @override
  _PlannerState createState() => _PlannerState();
}

class _PlannerState extends State<Planner> {

  List<Recipe> recipes = [];

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
      body: Center(
        child: Text('Planner'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => RecipifyDB.db.dropTableIfExistsThenReCreate(),
        child: Icon(Icons.delete),
      ),
    );
  }
}
