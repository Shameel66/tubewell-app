import 'package:flutter/material.dart';

class ThemeClass{

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Color.fromARGB(250, 0, 90, 125),
      colorScheme: ColorScheme.dark(),
      appBarTheme: AppBarTheme(
        backgroundColor: Color.fromARGB(255, 2, 31, 102),
      )
  );
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Color.fromARGB(250, 0, 90, 125),
      colorScheme: ColorScheme.dark(),
      appBarTheme: AppBarTheme(
        backgroundColor: Color.fromARGB(255, 2, 31, 102),
      )
  );
}