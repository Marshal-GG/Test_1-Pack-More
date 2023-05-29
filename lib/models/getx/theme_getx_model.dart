import 'package:flutter/material.dart';
import '../../core/color_schemes.g.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class ThemeModel {
  static final lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    colorScheme: lightColorScheme,
  );
  static final darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    colorScheme: darkColorScheme,
  );

  // static final ThemeModel _instance = ThemeModel._internal();

  // factory ThemeModel() {
  //   return _instance;
  // }

  // ThemeModel._internal();

  // // Add the necessary properties and methods to manage the theme mode
  // var themeMode = ThemeMode.light.obs;

  // void toggleTheme() {
  //   themeMode.value =
  //       themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  //   update();
  // }
}
