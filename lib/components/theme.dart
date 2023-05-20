import 'package:flutter/material.dart';

//Booking
Color availableColor = const Color.fromRGBO(46, 204, 113, 1);
Color pendingColor = const Color.fromRGBO(241, 196, 15, 1);
Color bookedColor = const Color.fromRGBO(208, 57, 43, 1);
Color academyColor = const Color.fromRGBO(27, 114, 192, 1);

//Gradient Background Colors
Color racket1Color = const Color.fromRGBO(27, 114, 192, 1);
Color racker2Color = const Color.fromRGBO(18, 57, 88, 1);

//Links

//Facebook
Color faceBookColor = const Color.fromRGBO(61, 106, 214, 1);

//WhatsApp
Color whatsAppColor = const Color.fromRGBO(70, 198, 85, 1);

//Instagram
Color instagramFirstColor = const Color.fromRGBO(115, 36, 193, 1);
Color instagramSecondColor = const Color.fromRGBO(196, 42, 103, 1);
Color instagramThirdColor = const Color.fromRGBO(220, 141, 64, 1);

//Location
Color locationColor = const Color.fromRGBO(241, 67, 54, 1);

//Theme
Color backgroundDark = const Color.fromRGBO(48, 48, 48, 1);
Color indiactorDark = const Color.fromRGBO(100, 255, 218, 1);
Color backgroundLight = const Color.fromRGBO(250, 250, 250, 1);
Color indicatorLight = const Color.fromRGBO(33, 150, 243, 1);
Color textColor = const Color.fromRGBO(255, 255, 255, 1);
Color textAndIconLightModeColor = const Color.fromRGBO(0, 0, 0, 1);
Color textAndIconDarkModeColor = const Color.fromRGBO(255, 255, 255, 1);

//Light Theme Data
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
  bottomNavigationBarTheme:
      BottomNavigationBarThemeData(selectedItemColor: indicatorLight),
  fontFamily: 'Cairo',
);
//Dark Theme Data
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
  bottomNavigationBarTheme:
      BottomNavigationBarThemeData(selectedItemColor: indiactorDark),
  fontFamily: 'Cairo',
);
