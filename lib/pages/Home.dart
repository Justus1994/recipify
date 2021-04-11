import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipify/views/Menu.dart';
import 'package:recipify/views/Planner.dart';
import 'package:recipify/views/Recipes.dart';

import '../components/NavigationBar.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int view = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: views(view, context),
      bottomNavigationBar:
          NavigationBar(onTap: onChangePage, selectedIndex: view),
    );
  }

  onChangePage(int index) {
    setState(() {
      view = index;
    });
    views(index, context);
  }
}

Widget views(int page, BuildContext context) {
  switch (page) {
    case 0:
      return Menu();
      break;
    case 1:
      return Planner();
      break;
    case 2:
      return Recipes();
      break;
  }
  return CircularProgressIndicator();
}
