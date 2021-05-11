import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipify/model/Recipe.dart';

import 'dart:io';

import 'package:recipify/styles.dart';

class FoodCard extends StatelessWidget {
  FoodCard({
    Key? key,
    required this.recipe,
    required this.name,
    required this.background,
    required this.active,
  }) : super(key: key);

  final Recipe recipe;
  final String name;
  final Color background;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        color: background,
        constraints: BoxConstraints.expand(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getText(active, name),
            getContent(recipe, context),
            getImage(recipe.imagePath, context),
          ],
        ),
      ),
    );
  }
}

Widget getText(bool active, String name) {
  return Container(
    child: Padding(
      padding: EdgeInsets.only(left: 20),
      child: RotatedBox(
          quarterTurns: 3,
          child: Container(
            padding: EdgeInsets.only(
              bottom: 5, // Space between underline and text
            ),
            decoration: active
                ? BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                    color: RecipifyColors.ACCENT_VARIANT,
                    width: 3.0, // Underline thickness
                  )))
                : BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                    color: Colors.transparent,
                    width: 3.0, // Underline thickness
                  ))),
            child: Text(
              name,
              style: TextStyle(
                color: RecipifyColors.BLACK,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          )),
    ),
  );
}

Widget getContent(Recipe recipe, BuildContext context) {
  return Flexible(
    child: Container(
      constraints:
          BoxConstraints.expand(width: MediaQuery.of(context).size.width * .6),
      padding: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        recipe.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Kcal ${recipe.energy}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 10),
            child: Wrap(
              verticalDirection: VerticalDirection.down,
              runSpacing: -10,
              spacing: 5,
              clipBehavior: Clip.antiAlias,
              children: [for (var tag in recipe.tags) Chip(label: Text(tag.name))],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget getImage(String imageUrl, BuildContext context) {
  return Container(
    constraints:
        BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .3),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: FileImage(File(imageUrl)), fit: BoxFit.cover),
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
