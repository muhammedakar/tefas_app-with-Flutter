import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstants {
  static const Color primaryColor = Color(0xff3f4b3a);
  static const Color secondaryColor = Color(0xffc1ee00);
  static const Color thirdColor = Color(0xff5680DB);
  static const Color forthColor = Color(0xffF26BBC);

  static final TextStyle titleTs =
      GoogleFonts.coiny(color: Colors.white38, fontSize: 25, height: 1);
  static TextStyle bottomTs({Color color = Colors.black45,double fontsize=16}) =>
      GoogleFonts.coiny(color: color, fontSize: fontsize, height: 1);
  static final moneyTs =
      GoogleFonts.bungee(fontSize: 60, color: Colors.black54);

  static const String memojiPath = "assets/images/memoji.png";
  static const String tlPath = "assets/images/tl.png";
  static const String dollarPath = "assets/images/dollar.png";
  static const String appbarTitle = "FONLARIM";

  static Text titlesText(String title) => Text(
        title,
        style: AppConstants.titleTs,
      );
}
