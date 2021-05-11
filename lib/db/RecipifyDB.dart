import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipify/model/Menu.dart';
import 'package:recipify/model/Recipe.dart';
import 'dart:io';

import 'package:sqflite/sqflite.dart';



class RecipifyDB {

  // Create a singleton
  RecipifyDB();

  static final RecipifyDB db = RecipifyDB();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await openDb();
    return _database!;
  }

  Future openDb() async {
    // Get the location of our apps directory. This is where files for our app, and only our app, are stored.
    // Files in this directory are deleted when the app is deleted.
    return await openDatabase(
        join(await getDatabasesPath(), "recipify.db"),
        version: 1,
        onOpen: (db) async {},
        onConfigure: (db) async =>
          await db.execute('''
            PRAGMA foreign_keys = ON; 
            PRAGMA full_column_names = ON;
            '''),
        onCreate: (Database db, int version) async {
          // Create tables
          await db.execute(createTableRecipe());
          await db.execute(createTableMenu());
        }
      );
  }

  String createTableRecipe() {
    return '''
          CREATE TABLE recipes(
            id INTEGER PRIMARY KEY autoincrement,
            name TEXT,
            meal INTEGER,
            description TEXT,
            energy INTEGER,
            image_path TEXT,
            tags TEXT
          )
          ''';
  }

  String createTableMenu() {
    return '''
          CREATE TABLE menus(
            id INTEGER PRIMARY KEY autoincrement,
            day String UNIQUE,
            breakfast_id INTEGER,
            lunch_id INTEGER,
            dinner_id INTEGER,
            FOREIGN KEY (breakfast_id) REFERENCES recipes (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
            FOREIGN KEY (lunch_id) REFERENCES recipes (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
            FOREIGN KEY (dinner_id) REFERENCES recipes (id) ON DELETE NO ACTION ON UPDATE NO ACTION
          )
          ''';
  }


  // ****** Recipes ********

  Future insertRecipe(Recipe recipe) async {
    log('INSERT NEW RECIPE');
    final db = await database;
    return db.insert('recipes', recipe.toMap());
  }

  Future updateRecipe(Recipe recipe) async {
    final db = await database;
    return db.update('recipes', recipe.toMap(),
        where: "id = ?", whereArgs: [recipe.id]);
  }

  Future<int> deleteRecipe(int id) async {
    log('DELETE RECIPE WITH ID: $id');

    final db = await database;
    return db.delete('recipes', where: "id = ?", whereArgs: [id]);
  }

  Future<int> deleteRecipeAndImage(Recipe recipe) async {
    deleteImage(recipe.imagePath);
    return deleteRecipe(recipe.id!);
  }
  Future<Recipe> getRecipe(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('recipes', where: "id = ?", whereArgs: [id]);

    return maps.isNotEmpty ? Recipe.fromMap(maps.first) : throw('Recipe with id : $id not found');
  }

  Future<List<Recipe>> getRecipes() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('recipes');
    List<Recipe> list = maps.isNotEmpty ? maps.map((note) => Recipe.fromMap(note)).toList() : [];

    return list;
  }

  // ****** Menus ********

  Future insertMenu(Menu menu) async {
    log('insert Menu : ${menu.toMap()} into DB');
    final db = await database;
    return db.insert('menus', menu.toMap());
  }

  Future<List<Menu>> getMenus() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('menus');
    List<Menu> list = maps.isNotEmpty ? maps.map((note) => Menu.fromMap(note)).toList() : [];
    return list;
  }

  Future<List<Recipe>> recipesForDay(String day) async {
    final db = await database;
    final List<Map<String, Object?>> maps = await db.rawQuery(
      '''
      SELECT menus.day, recipes.*
      FROM menus
      INNER JOIN recipes 
      ON recipes.id = breakfast_id
      OR recipes.id = lunch_id 
      OR recipes.id = dinner_id
      WHERE menus.day = '$day' 
      '''
    );
    log('Query DB for $day and found ${maps.length} Recipes. ${maps.toString()}');

    return maps.isNotEmpty ?  maps.map((note) => Recipe.fromMap(note)).toList() : [];

  }
  //JOIN recipes lunch ON lunch.id
  Future<Menu> getMenuForDay(String day) async {
    final db = await database;
    final List<Map<String, Object?>> maps = await db.rawQuery(
        '''
      SELECT
        menus.id, 
        menus.day, 
        breakfast.id as breakfast_id,
        breakfast.name as breakfast_name,
        breakfast.meal as breakfast_meal,
        breakfast.description as breakfast_description,
        breakfast.energy as breakfast_energy,
        breakfast.tags as breakfast_tags,
        lunch.id as lunch_id,
        lunch.name as lunch_name,
        lunch.meal as lunch_meal,
        lunch.description as lunch_description,
        lunch.energy as lunch_energy,
        lunch.tags as lunch_tags,    
        dinner.id as dinner_id,
        dinner.name as dinner_name,
        dinner.meal as dinner_meal,
        dinner.description as dinner_description,
        dinner.energy as dinner_energy,
        dinner.tags as dinner_tags
      FROM menus
        JOIN recipes breakfast ON breakfast.id = menus.breakfast_id
        JOIN recipes lunch ON lunch.id = menus.lunch_id 
        JOIN recipes dinner ON dinner.id = menus.dinner_id 
      WHERE menus.day = '$day' 
      '''
    );

    //log('Query DB for $day and found ${maps.length} Recipes. ${maps.toString()}');

    return maps.isNotEmpty ?  Menu.fromMap(maps.first) : throw('No Menu for day $day');

  }


  // ****** FileSystem Actions ******

  Future<String> saveImage(File file, String imageName) async {
    final appDir = await getApplicationDocumentsDirectory();
    final String path = appDir.path;
    final String imagePath = '$path/$imageName';
    await file.copy(imagePath);
    return imagePath;
  }

  Future deleteImage(String imagePath) async {
    await File(imagePath).delete();
  }



  // ****** Commands ********

  Future<void> dropTableIfExistsThenReCreate() async {
    final db = await database;
    await db.execute("DROP TABLE IF EXISTS menus");
    await db.execute(createTableMenu());
    await db.execute("DROP TABLE IF EXISTS recipes");
    await db.execute(createTableRecipe());
    log('######## DROPPED DB ########');
  }


}