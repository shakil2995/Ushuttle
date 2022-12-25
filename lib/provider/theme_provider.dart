import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  // static ThemeData get lightTheme => _lightTheme;
  // static ThemeData get darkTheme => _darkTheme;

  // get themeMode => null;

  // ThemeProvider._();

  // static ThemeData _lightTheme = ThemeData(
  //     primarySwatch: Colors.blue,
  //     brightness: Brightness.light,
  //     textTheme: TextTheme(
  //       headline1: GoogleFonts.montserrat(
  //         fontSize: 20,
  //         fontWeight: FontWeight.w500,
  //         color: Color.fromARGB(255, 0, 0, 0),
  //       ),
  //       headline2: GoogleFonts.montserrat(
  //         fontSize: 20,
  //         fontWeight: FontWeight.w500,
  //         color: Color.fromARGB(255, 0, 0, 0),
  //       ),
  //       subtitle1: GoogleFonts.montserrat(
  //         fontSize: 16,
  //         fontWeight: FontWeight.w500,
  //         color: Color.fromARGB(255, 0, 0, 0),
  //       ),
  //       subtitle2: GoogleFonts.montserrat(
  //         fontSize: 14,
  //         fontWeight: FontWeight.w500,
  //         color: Color.fromARGB(255, 0, 0, 0),
  //       ),
  //     ));
  // static ThemeData _darkTheme = ThemeData(
  //     primarySwatch: Colors.blue,
  //     brightness: Brightness.dark,
  //     textTheme: TextTheme(
  //       headline1: GoogleFonts.montserrat(
  //         fontSize: 20,
  //         fontWeight: FontWeight.w500,
  //         color: Color.fromARGB(255, 255, 255, 255),
  //       ),
  //       headline2: GoogleFonts.montserrat(
  //         fontSize: 20,
  //         fontWeight: FontWeight.w500,
  //         color: Color.fromARGB(255, 255, 255, 255),
  //       ),
  //       subtitle1: GoogleFonts.montserrat(
  //         fontSize: 16,
  //         fontWeight: FontWeight.w500,
  //         color: Color.fromARGB(255, 255, 255, 255),
  //       ),
  //       subtitle2: GoogleFonts.montserrat(
  //         fontSize: 14,
  //         fontWeight: FontWeight.w500,
  //         color: Color.fromARGB(255, 253, 253, 253),
  //       ),
  //     ));

}
