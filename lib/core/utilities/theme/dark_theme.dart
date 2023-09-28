import 'package:flutter/material.dart';

Color backgroundDark = const Color.fromRGBO(48, 48, 48, 1);
Color indiactorDark = const Color.fromRGBO(100, 255, 218, 1);

ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    scrolledUnderElevation: 0,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: backgroundDark,
  ),
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: backgroundDark,
  indicatorColor: indiactorDark,
  fontFamily: 'Cairo',
);
