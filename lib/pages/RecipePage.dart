import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipify/db/RecipifyDB.dart';
import 'dart:io';

import 'package:recipify/model/Recipe.dart';
import 'package:recipify/model/Tag.dart';

class RecipePage extends StatefulWidget {
  RecipePage({Key? key}) : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  int view = 0;

  File? _image;
  final picker = ImagePicker();
  final titleController = TextEditingController();
  final tagController = TextEditingController();
  final descController = TextEditingController();
  final tags = <String>[];

  getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 100);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<String> saveImage(imageName) async {
    if(_image == null) {
      return '';
    }
    final appDir = await getApplicationDocumentsDirectory();
    final String path = appDir.path;
    final String imagePath = '$path/$imageName.png';
    final File newImage = await _image!.copy(imagePath);
    setState(() {
      _image = newImage;
    });
    return imagePath;
  }

  readFiles() async {
    final appDir = await getApplicationDocumentsDirectory();
    final String path = appDir.path;
    try {
      final file = File('$path/image1.png');
      setState(() {
        _image = file;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget imagePicker() {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: _image != null
              ? BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(_image!),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      spreadRadius: 1,
                      blurRadius: 10,
                    )
                  ],
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black26,
                ),
          child: _image == null
              ? Center(
                  child: IconButton(
                      icon: Icon(Icons.add_a_photo_rounded),
                      iconSize: 40,
                      onPressed: getImage),
                )
              : null,
        ),
      ),
    );
  }

  Widget recipeTitle() {
    return Container(
      child: TextField(
        controller: titleController,
        minLines: 1,
        maxLines: 2,
        scrollPhysics: NeverScrollableScrollPhysics(),
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          labelText: "Enter a title for your recipe",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget chipInput() {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 80),
      child: IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            controller: tagController,
            autocorrect: false,
            decoration:
                InputDecoration(border: InputBorder.none, hintText: 'add tags'),
            onSubmitted: (String val) {
              setState(() {
                tags.add(val);
              });
              tagController.clear();
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                recipeTitle(),
                imagePicker(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    children: [
                      for (int index = 0; index < tags.length; index++)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: InputChip(
                            backgroundColor: Colors.black,
                            deleteIconColor: Colors.white,
                            label: Text(
                              tags[index],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onDeleted: () {
                              setState(() {
                                tags.removeAt(index);
                              });
                            },
                          ),
                        ),
                      chipInput(),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Provide description'),
                    controller: descController,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if(titleController.text.isEmpty) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('You must at least provide a Name for your Recipe')));
            return;
          }
          final imagePath = await RecipifyDB.db.saveImage(_image!, titleController.text);

          final newRecipe = Recipe(
            meal: Meal.ANY,
            name: titleController.text,
            description: descController.text,
            energy: 20,
            imagePath: imagePath,
            tags: tags.map((e) => Tag(name: e, type: Type.TAG)).toList(),
          );

          Navigator.pop(context, newRecipe);
        },
        child: Icon(Icons.save),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleController.dispose();
    descController.dispose();
    tagController.dispose();
    super.dispose();
  }
}
