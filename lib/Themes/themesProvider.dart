import 'package:flutter/material.dart';
import 'package:notes_app_with_isar/Themes/dark.dart';
import 'package:notes_app_with_isar/Themes/light.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  ThemeData getTheme() {
    return _isDarkMode ? darkTheme : lightTheme;
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}