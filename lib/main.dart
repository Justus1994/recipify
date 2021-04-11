import 'package:flutter/material.dart';
import 'package:recipify/pages/Home.dart';

void main() {
  runApp(Recipify());
}

final routes = {
  '/': (BuildContext context) => Home(),
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
