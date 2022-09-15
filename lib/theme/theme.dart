import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  static bool isDarkTheme = false;
  ThemeMode get themeMode => isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }
}

AppTheme appTheme = AppTheme();
