import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tefas_app/constants/color_constant.dart';
import 'package:tefas_app/models/gheet_data_model.dart';
import 'package:tefas_app/models/locale_data_model.dart';

// ignore: must_be_immutable
class PieChartWid extends StatelessWidget {
  final List<LocaleDataModel> portfolio;
  final List<DataGsheetsData> result;
  PieChartWid({super.key, required this.portfolio, required this.result});

  Map<String, double>? myMap = {};
  double loopsMethod() {
    double toplam = 0;
    for (var e in portfolio) {
      myMap!.addEntries({MapEntry(e.fonKodu!, double.parse(e.maliyet!))});
    }

    for (int i = 0; i < portfolio.length; i++) {
      int indexOfkod = result.indexWhere(
        (element) => element.fonKodu == portfolio[i].fonKodu,
      );
      toplam += double.parse(portfolio[i].adet!) *
          double.parse(result[indexOfkod].fiyat!);
    }
    return toplam;
  }

  List<Color> colors = [
    Colors.red,
    Clr.primary,
    Colors.green,
    Colors.brown,
    Colors.teal,
    Colors.pink,
    Colors.lightGreen,
    Colors.cyan,
    Colors.blueGrey,
    Colors.black,
    Colors.deepOrangeAccent,
    Colors.deepPurpleAccent,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.indigo,
    Colors.amber,
  ];
  int i = 0;

  @override
  Widget build(BuildContext context) {
    loopsMethod();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(
              children: [
                myMap!.entries.isEmpty
                    ? PieChart(PieChartData(sections: [
                        PieChartSectionData(
                          color: Clr.primary.shade200,
                          radius: 30,
                        )
                      ]))
                    : PieChart(
                        PieChartData(
                          sections: myMap!.entries.map((entry) {
                            String key = entry.key;
                            double value = entry.value;
                            int currentIndex = i++;

                            return PieChartSectionData(
                                radius: 30,
                                value: value,
                                color: currentIndex > colors.length - 1
                                    ? Colors.red
                                    : colors[currentIndex],
                                title: key,
                                titleStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Clr.primary.shade50,
                                        fontWeight: FontWeight.bold));
                          }).toList(),
                        ),
                      ),
                Center(
                    child: Text(
                  '${loopsMethod().toStringAsFixed(2)}₺',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Clr.primary, fontWeight: FontWeight.bold),
                ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
