

import 'dart:developer';
import 'dart:typed_data';

import 'Tag.dart';
import 'dart:convert';

class Recipe {
  int? id;
  String name;
  Meal meal;
  String description;
  int energy;
  Uint8List image;
  List<Tag> tags;


  Recipe({
    this.id,
    required this.meal,
    required this.name,
    required this.description,
    required this.energy,
    required this.image,
    required this.tags
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'meal' : meal.index,
      'description' : description,
      'energy' : energy,
      'image' : image,
      'tags' : jsonEncode(tags)
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map, {String prefix = ''}) {
    return Recipe(
      id: map['${prefix}id'],
      name: map['${prefix}name'],
      meal: Meal.values.elementAt(map['${prefix}meal']),
      description: map['${prefix}description'],
      energy: map['${prefix}energy'],
      image: map['${prefix}image'],
      tags: (json.decode(map['${prefix}tags']) as List).map((i) => Tag.fromJson(i)).toList(),
    );
  }

  @override
  String toString() {
    return 'Recipe{id: $id, name: $name, meal: $meal, description: $description, energy: $energy, image: SomeBytes, tags: $tags}';
  }
}

enum Meal {BREAKFAST, LUNCH, DINNER, ANY}