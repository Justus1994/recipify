import 'package:flutter/material.dart';

class Planner extends StatefulWidget {
  Planner({Key key}) : super(key: key);

  @override
  _PlannerState createState() => _PlannerState();
}

class _PlannerState extends State<Planner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Planner"),
      ),
    );
  }
}
