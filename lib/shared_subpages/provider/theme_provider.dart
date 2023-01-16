import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = ThemeData.dark();
  ThemeData get themeData => _theme;
  bool get isDark => _theme == ThemeData.dark();
  get theme => _theme;
  void toggleTheme() {
    final isDark = _theme == ThemeData.dark();
    _theme = isDark ? ThemeData.light() : ThemeData.dark();
    notifyListeners();
  }
}
