import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tefas_app/models/gheet_data_model.dart';
import 'package:tefas_app/models/locale_data_model.dart';
import 'package:tefas_app/service/locale_service.dart';

import '../constants/app_constants.dart';
import '../pages/home_page.dart';

class PortfolioWid extends StatefulWidget {
  final List<DataGsheetsData> result;
  final bool switchValue;
  const PortfolioWid(
      {super.key, required this.result, required this.switchValue});

  @override
  State<PortfolioWid> createState() => _PortfolioWidState();
}

class _PortfolioWidState extends State<PortfolioWid> {
  final LocalService localService = LocalService();
  String? ilkDeger;
  @override
  void initState() {
    ilkDeger = widget.result[0].fonKodu!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title(),
        cardItemBuilder(),
      ],
    );
  }

  FutureBuilder<List<LocaleDataModel>> cardItemBuilder() {
    return FutureBuilder<List<LocaleDataModel>>(
        future: localService.getAllList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              List<LocaleDataModel>? result = snapshot.data;
              return SizedBox(
                height: 250.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: result!.length,
                    itemBuilder: (context, index) {
                      LocaleDataModel data = result[index];
                      int indexOfkod = widget.result.indexWhere(
                          (element) => element.fonKodu == data.fonKodu);
                      double suankideger = double.parse(data.adet!) *
                          double.parse(widget.result[indexOfkod].fiyat!);
                      double suankidolardeger = suankideger /
                          double.parse(widget.result[indexOfkod].dolar!);
                      return GestureDetector(
                        onLongPress: () => _showDeleteDialog(data.id!),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            width: 250.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppConstants.secondaryColor),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  percentValue(indexOfkod),
                                  Expanded(
                                    flex: 3,
                                    child: firstRow(data),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: secondRow(
                                          suankideger, suankidolardeger)),
                                  Expanded(
                                      flex: 2,
                                      child: thirdRow(
                                          suankideger, data, suankidolardeger)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 32.0, horizontal: 10),
                child: Center(
                    child: Text(
                  "Porföyünüzde fon bulunmamaktadır.",
                  maxLines: 1,
                  style: AppConstants.titleTs,
                  textScaleFactor: 0.8,
                )),
              );
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Padding title() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 8,
        right: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Portföyümm",
            style: AppConstants.titleTs,
          ),
          TextButton(
              onPressed: () {
                LocalService.alertDialog(widget.result, context);
              },
              child: Text(
                "+ Fon Ekle",
                style: AppConstants.titleTs,
                textScaleFactor: 0.7,
              ))
        ],
      ),
    );
  }

  Row thirdRow(
      double suankideger, LocaleDataModel data, double suankidolardeger) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Kazanç:\n${kazanc(widget.switchValue ? [
              suankideger,
              data.maliyet!
            ] : [suankidolardeger, data.dolarMaliyet!])}",
          textAlign: TextAlign.center,
          style: AppConstants.moneyTs,
          textScaleFactor: 0.2,
        ),
        Text(
          "Değişim:\n%${degisim(suankideger, data.maliyet!)}",
          textAlign: TextAlign.center,
          style: AppConstants.moneyTs,
          textScaleFactor: 0.2,
        ),
        Text(
          "Adet:\n${data.adet}",
          textAlign: TextAlign.center,
          style: AppConstants.moneyTs,
          textScaleFactor: 0.2,
        ),
      ],
    );
  }

  Center secondRow(double suankideger, double suankidolardeger) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: AutoSizeText(
              widget.switchValue
                  ? "${suankideger.toStringAsFixed(2)} ₺"
                  : "${suankidolardeger.toStringAsFixed(2)} \$",
              maxLines: 1,
              textScaleFactor: 0.6,
              style: AppConstants.moneyTs,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppConstants.thirdColor,
            size: 40,
          )
        ],
      ),
    );
  }

  Row firstRow(LocaleDataModel data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white.withOpacity(0.8),
            ),
            child: Center(
                child: Text(
              data.fonKodu!,
              style: AppConstants.moneyTs,
              textScaleFactor: 0.4,
            )),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            data.fonAdi!,
            style: AppConstants.bottomTs(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Align percentValue(int indexOfkod) {
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        "%${double.parse(widget.result[indexOfkod].gunluk!).toStringAsFixed(2)}",
        style: AppConstants.bottomTs(
          color: double.parse(widget.result[indexOfkod].gunluk!) > 0
              ? Colors.green
              : Colors.red,
        ),
      ),
    );
  }

  String kazanc(List? dolarOrTl) {
    return (dolarOrTl![0] - double.parse(dolarOrTl[1])).toStringAsFixed(2);
  }

  String degisim(double suankideger, String maliyet) {
    return ((suankideger - double.parse(maliyet)) / double.parse(maliyet) * 100)
        .toStringAsFixed(2);
  }

  _showDeleteDialog(String id) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: AppConstants.secondaryColor,
              actions: [
                TextButton(
                    onPressed: () async {
                      await localService.deletePortfolio(id);
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const HomePage(); // Sayfanın adını ve yapısını buraya ekleyin
                      }));
                    },
                    child: Text("EVET",
                        style: AppConstants.bottomTs(color: Colors.red))),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "HAYIR",
                    style:
                        AppConstants.bottomTs(color: AppConstants.thirdColor),
                  ),
                ),
              ],
              content: Text(
                "İlgili fon silinecek onaylıyor musunuz?",
                style: AppConstants.moneyTs,
                textScaleFactor: 0.25,
              ),
            ));
  }
}
