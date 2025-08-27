import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme {
  system,
  light,
  dark,
  mangaGreen,
  mangaBlue,
  mangaPurple,
}

class ThemeManager extends ChangeNotifier {
  AppTheme _currentTheme = AppTheme.system;
  
  AppTheme get currentTheme => _currentTheme;

  ThemeManager() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? themeString = prefs.getString('app_theme');
    if (themeString != null) {
      _currentTheme = AppTheme.values.firstWhere(
        (theme) => theme.toString() == themeString,
        orElse: () => AppTheme.system,
      );
      notifyListeners();
    }
  }

  Future<void> setTheme(AppTheme theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_theme', theme.toString());
    _currentTheme = theme;
    notifyListeners();
  }

  // Light theme
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
  );

  // Dark theme
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade900,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );

  // Manga Green theme
  static ThemeData get mangaGreenTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 6, 132, 14),
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 6, 132, 14),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    scaffoldBackgroundColor: Colors.green.shade50,
  );

  // Manga Blue theme
  static ThemeData get mangaBlueTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 6, 90, 132),
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 6, 90, 132),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    scaffoldBackgroundColor: Colors.blue.shade50,
  );

  // Manga Purple theme
  static ThemeData get mangaPurpleTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 90, 6, 132),
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 90, 6, 132),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    scaffoldBackgroundColor: Colors.purple.shade50,
  );

  // Get the current theme data
  ThemeData getThemeData(BuildContext context) {
    switch (_currentTheme) {
      case AppTheme.system:
        return Theme.of(context).brightness == Brightness.dark 
          ? darkTheme 
          : lightTheme;
      case AppTheme.light:
        return lightTheme;
      case AppTheme.dark:
        return darkTheme;
      case AppTheme.mangaGreen:
        return mangaGreenTheme;
      case AppTheme.mangaBlue:
        return mangaBlueTheme;
      case AppTheme.mangaPurple:
        return mangaPurpleTheme;
    }
  }

  // Get theme mode for MaterialApp
  ThemeMode get themeMode {
    switch (_currentTheme) {
      case AppTheme.system:
        return ThemeMode.system;
      case AppTheme.light:
      case AppTheme.mangaGreen:
      case AppTheme.mangaBlue:
      case AppTheme.mangaPurple:
        return ThemeMode.light;
      case AppTheme.dark:
        return ThemeMode.dark;
    }
  }
}