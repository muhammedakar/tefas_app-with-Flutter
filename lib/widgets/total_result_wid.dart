import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:tefas_app/constants/app_constants.dart';
import 'package:tefas_app/models/gheet_data_model.dart';
import 'package:tefas_app/models/locale_data_model.dart';
import 'package:tefas_app/service/locale_service.dart';

class TotalResultWid extends StatefulWidget {
  final List<DataGsheetsData> list;
  final bool switchValue;
  const TotalResultWid(
      {super.key, required this.list, required this.switchValue});

  @override
  State<TotalResultWid> createState() => _TotalResultWidState();
}

class _TotalResultWidState extends State<TotalResultWid> {
  final LocalService localService = LocalService();
  Map<String, double>? myMap = {};

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LocaleDataModel>>(
        future: localService.getAllList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<LocaleDataModel> result = snapshot.data!;
            double toplamDeger = loopsMethod(result);
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: double.infinity,
              height: 250.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppConstants.secondaryColor),
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: result.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex: 6, child: pieChartBuilder(toplamDeger)),
                            Divider(
                              endIndent: 45.w,
                              indent: 45.w,
                              thickness: 3.h,
                              color: AppConstants.thirdColor,
                            ),
                            Expanded(flex: 1, child: currencyRowBuilder())
                          ],
                        )
                      : Center(
                          child: Text(
                          "Portföyünüzde fon bulunmamaktadır",
                          style: AppConstants.bottomTs()
                        ))),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Row currencyRowBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        currencyText(
            "USD\n${double.parse(widget.list[0].dolar!).toStringAsFixed(2)}",
            "₺"),
        currencyText(
            "EUR\n${double.parse(widget.list[0].eur!).toStringAsFixed(2)}",
            "₺"),
        currencyText(
            "GBP\n${double.parse(widget.list[0].sterlin!).toStringAsFixed(2)}",
            "₺"),
        currencyText(
            "BİST100\n${double.parse(widget.list[0].bist!).toStringAsFixed(2)}",
            "₺"),
        currencyText(
            "BTC\n${double.parse(widget.list[0].btc!).toStringAsFixed(2)}",
            "\$"),
      ],
    );
  }

  PieChart pieChartBuilder(double toplamDeger) {
    return PieChart(
      chartRadius: 145.sp,
      dataMap: myMap!,
      centerText: toplamDeger.toStringAsFixed(2),
      centerTextStyle:
          AppConstants.bottomTs(color: AppConstants.primaryColor, fontsize: 18),
      degreeOptions: const DegreeOptions(
        initialAngle: 45,
      ),
      chartValuesOptions: ChartValuesOptions(
          showChartValues: true,
          showChartValueBackground: false,
          decimalPlaces: 1,
          chartValueStyle: AppConstants.bottomTs(color: Colors.black),
          showChartValuesInPercentage: true,
          showChartValuesOutside: true),
      chartType: ChartType.ring,
      ringStrokeWidth: 30,
    );
  }

  Expanded currencyText(String value, String currency) {
    return Expanded(
      child: Text(
        "$value $currency",
        style: AppConstants.moneyTs,
        textAlign: TextAlign.center,
        textScaleFactor: 0.2,
      ),
    );
  }

  ///Bu metod içerisinde piechart için map oluşturyor ve aynı zamanda pie chart centerTexti için toplam değeri
  double loopsMethod(List<LocaleDataModel> result) {
    double toplam = 0;
    for (var e in result) {
      myMap!.addEntries({MapEntry(e.fonKodu!, double.parse(e.maliyet!))});
    }

    for (int i = 0; i < result.length; i++) {
      int indexOfkod = widget.list.indexWhere(
        (element) => element.fonKodu == result[i].fonKodu,
      );
      toplam += widget.switchValue
          ? double.parse(result[i].adet!) *
              double.parse(widget.list[indexOfkod].fiyat!)
          : double.parse(result[i].adet!) *
              double.parse(widget.list[indexOfkod].fiyat!) /
              double.parse(widget.list[0].dolar!);
    }
    return toplam;
  }
}
