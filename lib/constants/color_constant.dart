import 'package:flutter/material.dart';

class Clr {
  static const MaterialColor primary =
      MaterialColor(_primaryPrimaryValue, <int, Color>{
    50: Color(0xFFE0E9F5),
    100: Color(0xFFB3C9E6),
    200: Color(0xFF80A5D6),
    300: Color(0xFF4D80C6),
    400: Color(0xFF2665B9),
    500: Color(_primaryPrimaryValue),
    600: Color(0xFF0043A6),
    700: Color(0xFF003A9C),
    800: Color(0xFF003293),
    900: Color(0xFF002283),
  });
  static const int _primaryPrimaryValue = 0xFF004AAD;

  static const MaterialColor primaryAccent =
      MaterialColor(_primaryAccentValue, <int, Color>{
    100: Color(0xFFB0BEFF),
    200: Color(_primaryAccentValue),
    400: Color(0xFF4A6AFF),
    700: Color(0xFF3056FF),
  });
  static const int _primaryAccentValue = 0xFF7D94FF;
}
