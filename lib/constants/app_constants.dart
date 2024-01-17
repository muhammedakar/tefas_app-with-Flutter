import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstants {
  static const Color primaryColor = Colors.white;
  static const Color secondaryColor = Color(0xffc1ee00);
  static const Color thirdColor = Color(0xff5680DB);
  static const Color forthColor = Color(0xffF26BBC);

  static final TextStyle titleTs =
      GoogleFonts.coiny(color: Colors.black54, fontSize: 22, height: 1);
  static TextStyle bottomTs(
          {Color color = Colors.black45, double fontsize = 16}) =>
      GoogleFonts.coiny(color: color, fontSize: fontsize, height: 1);
  static  moneyTs({double fontSize = 60}) =>
      GoogleFonts.bungee(fontSize: fontSize, color: Colors.black54);
  static final cuurencyTs =
      GoogleFonts.bungee(fontSize: 60, color: Colors.white);

  static const String memojiPath = "assets/images/logo.png";
  static const String tlPath = "assets/images/tl.svg";
  static const String dollarPath = "assets/images/dollar.svg";
  static const String appbarTitle = "FONLARIM";

  static Text titlesText(String title) => Text(
        title,
        style: AppConstants.titleTs,
      );
}
