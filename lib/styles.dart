
import 'package:flutter/material.dart';

class RecipifyColors {

  static const Color ACCENT = Color.fromARGB(255, 255, 238, 230);
  static const Color ACCENT_VARIANT = Color.fromARGB(255, 241, 151, 115);

  static const Color WHITE = Color.fromARGB(255, 250, 250, 250);
  static const Color BLACK = Color.fromARGB(255, 18, 18, 18);
  static const Color BLACK_01 = Color.fromARGB(200, 18, 18, 18);

}

class AppTheme {

  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      centerTitle: true,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: RecipifyColors.BLACK,
          fontFamily: 'Pacifico',
          fontSize: 26,
        ),
      ),
      elevation: 0,
      backgroundColor: RecipifyColors.WHITE,
      iconTheme: IconThemeData(
        color: RecipifyColors.BLACK,
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: RecipifyColors.BLACK,
      disabledColor: RecipifyColors.BLACK, 
      labelStyle: TextStyle(),
      secondaryLabelStyle: TextStyle(),
      selectedColor: RecipifyColors.ACCENT,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      secondarySelectedColor: RecipifyColors.ACCENT_VARIANT,
      brightness: Brightness.light,
    ),
    fontFamily: 'Poppins',
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: RecipifyColors.ACCENT_VARIANT,
        selectedLabelStyle: TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.w600
        ),
        unselectedLabelStyle: TextStyle(
          color: RecipifyColors.BLACK,
          fontWeight: FontWeight.w600,
        ),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedIconTheme: IconThemeData(
          color: RecipifyColors.BLACK,
        ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.redAccent,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.black,
      primaryVariant: Colors.black,
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
  );
}