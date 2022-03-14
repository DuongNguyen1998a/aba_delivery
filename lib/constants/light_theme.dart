import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightTheme {
  ThemeData lightTheme = ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(),
    colorScheme:
        ThemeData().colorScheme.copyWith(secondary: Colors.orangeAccent),
    primaryColor: Colors.blueAccent,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.blueAccent),
      elevation: 0.7,
      centerTitle: true,
      color: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.blueGrey,
        letterSpacing: 1,
        fontWeight: FontWeight.w600,
        fontSize: 17,
      ),
    ),
  );
}
