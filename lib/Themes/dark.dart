import 'package:flutter/material.dart';


const Color darkBackgroundColor = Color(0xFF121212);
const Color darkTileColor = Color(0xFF2C2C2C);
const Color darkTextColor = Color(0xFFE0E0E0);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0x31213000),
primaryColorDark: Colors.black,
  primaryColorLight: Colors.white,
  backgroundColor: darkBackgroundColor,
  scaffoldBackgroundColor: darkBackgroundColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0x52484800),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: darkTextColor),
    bodyText2: TextStyle(color: darkTextColor),
    
  ),
  cardColor: darkTileColor, // Tile color for dark mode
);
