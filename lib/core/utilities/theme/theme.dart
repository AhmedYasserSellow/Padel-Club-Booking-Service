import 'package:flutter/material.dart';

abstract class AppTheme {
//Booking
  static Color availableColor = const Color.fromRGBO(46, 204, 113, 1);
  static Color pendingColor = const Color.fromRGBO(241, 196, 15, 1);
  static Color bookedColor = const Color.fromRGBO(208, 57, 43, 1);
  static Color academyColor = const Color.fromRGBO(27, 114, 192, 1);

//Gradient Background Colors
  static Color racketFirstColor = const Color.fromRGBO(27, 114, 192, 1);
  static Color racketSecondColor = const Color.fromRGBO(18, 57, 88, 1);

//Links

//Facebook
  static Color faceBookColor = const Color.fromRGBO(61, 106, 214, 1);

//WhatsApp
  static Color whatsAppColor = const Color.fromRGBO(70, 198, 85, 1);

//Instagram
  static Color instagramFirstColor = const Color.fromRGBO(115, 36, 193, 1);
  static Color instagramSecondColor = const Color.fromRGBO(196, 42, 103, 1);
  static Color instagramThirdColor = const Color.fromRGBO(220, 141, 64, 1);

//Location
  static Color locationColor = const Color.fromRGBO(241, 67, 54, 1);

//Text and Icon Colors

  static Color whiteTextColor = const Color.fromRGBO(255, 255, 255, 1);
  static Color textAndIconLightCoLor = const Color.fromRGBO(0, 0, 0, 1);
  static Color textAndIconDarkColor = const Color.fromRGBO(255, 255, 255, 1);

//Light Theme

  static Color backgroundLight = const Color.fromRGBO(250, 250, 250, 1);
  static Color indicatorLight = const Color.fromRGBO(33, 150, 243, 1);

  static ThemeData lightTheme = ThemeData(
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

//Dark Theme
  static Color backgroundDark = const Color.fromRGBO(48, 48, 48, 1);
  static Color indiactorDark = const Color.fromRGBO(100, 255, 218, 1);
  static ThemeData darkTheme = ThemeData(
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
}
