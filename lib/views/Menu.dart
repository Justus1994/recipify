import 'package:flutter/material.dart';
import 'package:recipify/components/FoodCard.dart';
import 'package:recipify/db/RecipifyDB.dart';
import 'package:recipify/model/Recipe.dart';
import 'package:recipify/styles.dart';
import 'package:recipify/model/Menu.dart' as Models;

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {


  Models.Menu? menu;


  @override
  void initState() {
    RecipifyDB.db.getRecipes().then((value) => {
      setState(() {
        menu = Models.Menu(
          day: DateTime.now(),
          breakfast: value[0],
          lunch: value[1],
          dinner: value[2],
        );
      })
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Icon(Icons.sort_rounded),
        title: Text("Recipify"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Align(
                    child: Row(
                      children: [
                        menu != null ? Text("${menu!.getWeekday()} ${(menu!.getDisplayDate())}",
                          style:TextStyle(
                            color: RecipifyColors.BLACK,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ) : Text(''),
                        Text(" | 1242 Kcal", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    alignment: Alignment.centerLeft),
              ),
              menu != null ?
              FoodCard(
                  recipe: menu!.breakfast!,
                  name: 'BREAKFAST',
                  background: Colors.white,
                  active: true)
                : CircularProgressIndicator(),
              menu != null ?
              FoodCard(
                  recipe: menu!.lunch!,
                  name: 'LUNCH',
                  background: RecipifyColors.ACCENT,
                  active: true)
                  : CircularProgressIndicator(),
              menu != null ? FoodCard(
                  recipe: menu!.dinner!,
                  name: 'DINNER',
                  background: Colors.white,
                  active: true): CircularProgressIndicator(),
              SizedBox(
                height: 20,
              )
            ],
          )
      ),
    );
  }
}
