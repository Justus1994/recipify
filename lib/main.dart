import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipify/pages/Home.dart';
import 'package:recipify/pages/RecipePage.dart';
import 'package:recipify/styles.dart';

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
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        )
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routes: routes,
    );
  }
}
