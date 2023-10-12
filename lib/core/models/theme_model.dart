import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../color_schemes.g.dart';

class ThemeProvider extends ChangeNotifier {
  static final lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    colorScheme: lightColorScheme,
    brightness: Brightness.light,
  );
  static final darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    colorScheme: darkColorScheme,
    brightness: Brightness.dark,
  );

  ThemeMode themeMode = ThemeMode.dark;

  static const _themeModeKey = 'themeMode';

  ThemeProvider() {
    _loadThemeMode();
  }

  bool get isDarkMode => themeMode == ThemeMode.dark;

  Future<void> toggleTheme(bool isOn) async {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    await _saveThemeMode();
  }

  // Save the theme mode to SharedPreferences
  Future<void> _saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, isDarkMode ? 'dark' : 'light');
  }

  // Load the theme mode from SharedPreferences
  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedThemeMode = prefs.getString(_themeModeKey);
    if (savedThemeMode == 'light') {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }
}
