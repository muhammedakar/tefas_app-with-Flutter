import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_constant.dart';


class AppThemes {
  static final lightTheme = ThemeData(
      textTheme: GoogleFonts.openSansTextTheme(),
      brightness: Brightness.light,
      primaryColor: Clr.primary.shade500,
      primarySwatch: Clr.primary,
      iconTheme: IconThemeData(color: Clr.primary.shade200),
      scaffoldBackgroundColor: Clr.primary.shade50);
}
