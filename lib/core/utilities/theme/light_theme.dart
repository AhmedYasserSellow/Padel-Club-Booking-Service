import 'package:flutter/material.dart';

Color backgroundLight = const Color.fromRGBO(250, 250, 250, 1);
Color indicatorLight = const Color.fromRGBO(33, 150, 243, 1);

ThemeData lightTheme = ThemeData(
  dialogTheme: DialogTheme(
    backgroundColor: backgroundLight,
  ),
  appBarTheme: const AppBarTheme(
    scrolledUnderElevation: 0,
  ),
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: backgroundLight,
  indicatorColor: indicatorLight,
  fontFamily: 'Cairo',
);
