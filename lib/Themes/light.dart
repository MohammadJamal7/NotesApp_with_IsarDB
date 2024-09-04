import 'package:flutter/material.dart';

const Color lightBackgroundColor = Color(0xFFF5F5F5);
const Color lightTileColor = Colors.black;
const Color lightTextColor = Colors.black;

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color.fromARGB(255, 245, 245, 245),
  primaryColorLight: Colors.black,
  primaryColorDark: Colors.black,
  backgroundColor: lightBackgroundColor,
  scaffoldBackgroundColor: lightBackgroundColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 5,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: lightTextColor),
    

  ),
  cardColor: lightTileColor, // Tile color for light mode
);
