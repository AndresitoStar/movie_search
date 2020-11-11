import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Dosis',
    scaffoldBackgroundColor: Color(0xffF5F5F5),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      textTheme: TextTheme(
        title: TextStyle(color: Colors.black12),
      ),
      iconTheme: IconThemeData(
        color: Colors.black87,
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      clipBehavior: Clip.hardEdge,
      elevation: 5,
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.white,
      primaryVariant: Colors.white38,
      secondary: Colors.red,
    ),
    iconTheme: IconThemeData(
      color: Colors.black87,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.black12),
    ),
    textTheme: new TextTheme(
      headline4: TextStyle(color: Colors.black87),
      headline6: TextStyle(color: Colors.black87),
      button: TextStyle(color: Colors.black54),
      caption: TextStyle(color: Colors.black54),
      subtitle1: TextStyle(color: Colors.black54),
      subtitle2: TextStyle(color: Colors.black54),
      bodyText1: TextStyle(color: Colors.black54),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'Dosis',
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    scaffoldBackgroundColor: Colors.black87,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        title: TextStyle(color: Colors.white12),
      ),
      color: Color(0xff19171c),
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: Color(0xff19171c),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      clipBehavior: Clip.hardEdge,
      elevation: 5,
    ),
    dividerColor: Colors.white70,
    dialogTheme: DialogTheme(
      backgroundColor: Colors.black,
    ),
    inputDecorationTheme: InputDecorationTheme(hintStyle: TextStyle(color: Colors.white12)),
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.black,
      primaryVariant: Colors.black,
      secondary: Colors.red,
    ),
    textTheme: new TextTheme(
      headline4: TextStyle(color: Colors.white70),
      headline6: TextStyle(color: Colors.white70),
      button: TextStyle(color: Colors.white60),
      caption: TextStyle(color: Colors.white54),
      subtitle1: TextStyle(color: Colors.white54),
      subtitle2: TextStyle(color: Colors.white54),
      bodyText1: TextStyle(color: Colors.white54),
    ),
  );
}
