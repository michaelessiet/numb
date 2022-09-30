import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:numb/constants/colors.dart';

class AppTheme with ChangeNotifier {
  final box = GetStorage();
  ThemeMode get themeMode =>
      box.read('darkMode') != null && box.read('darkMode') == true
          ? ThemeMode.dark
          : ThemeMode.light;

  void init() {
    box.writeIfNull('darkMode', false);
    bool? darkMode = box.read('darkMode');
    print(darkMode);
  }

  void toggleTheme() {
    // box.erase();
    // box.writeIfNull('darkMode', false);
    box.write('darkMode', !box.read('darkMode'));
    notifyListeners();
  }
}

AppTheme appTheme = AppTheme();

ThemeData lightThemeData = ThemeData(
    appBarTheme: const AppBarTheme(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarBrightness: Brightness.light)),
    brightness: Brightness.light,
    fontFamily: 'Inconsolata',
    primaryColor: myWhiteGrey,
    primaryIconTheme: const IconThemeData(color: myDarkGrey, size: 36),
    primaryTextTheme: const TextTheme(
        bodyLarge: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: myDarkGrey),
        titleMedium: TextStyle(
            fontSize: 24, fontWeight: FontWeight.w600, color: myDarkGrey),
        titleLarge: TextStyle(
            fontSize: 32, fontWeight: FontWeight.w600, color: myDarkGrey),
        bodyMedium: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: myLightBlue)),
    hintColor: myDarkGrey50,
    backgroundColor: myWhiteGrey,
    dividerColor: myDarkGrey);

ThemeData darkThemeData = ThemeData(
    appBarTheme: const AppBarTheme(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarBrightness: Brightness.dark)),
    brightness: Brightness.dark,
    fontFamily: 'Inconsolata',
    primaryColor: myDarkGrey,
    primaryIconTheme: const IconThemeData(color: myWhiteGrey, size: 36),
    primaryTextTheme: const TextTheme(
        bodyLarge: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: myWhiteGrey),
        titleMedium: TextStyle(
            fontSize: 24, fontWeight: FontWeight.w600, color: myWhiteGrey),
        titleLarge: TextStyle(
            fontSize: 32, fontWeight: FontWeight.w600, color: myWhiteGrey),
        bodyMedium: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: myLightBlue)),
    hintColor: myWhiteGrey50,
    backgroundColor: myDarkGrey,
    dividerColor: myWhiteGrey);
