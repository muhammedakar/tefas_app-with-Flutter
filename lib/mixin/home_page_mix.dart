import 'package:flutter/material.dart';
import 'package:tefas_app/constants/color_constant.dart';
import 'package:tefas_app/pages/home_page.dart';
import 'package:tefas_app/service/data_gheets.dart';
import 'package:tefas_app/service/locale_service.dart';

mixin HomePageMix on State<HomePage>{
  int currentPage = 0;
  int touchedIndex = -1;
  final DataGsheets dataGsheets = DataGsheets();
  final LocalService localService = LocalService();
   Widget indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 30 : 8,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Clr.primary),
    );
  }

  List<Widget> buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 2; i++) {
      if (currentPage == i) {
        indicators.add(indicator(true));
      } else {
        indicators.add(indicator(false));
      }
    }
    return indicators;
  }
}