import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';
import 'package:tefas_app/models/gheet_data_model.dart';
import 'package:tefas_app/models/locale_data_model.dart';
import 'package:tefas_app/pages/home_page.dart';
import 'package:tefas_app/service/locale_service.dart';
import 'package:uuid/uuid.dart';

import '../constants/app_constants.dart';

// ignore: must_be_immutable
class AlertDialogWid extends StatefulWidget {
  final List<DataGsheetsData> list;
  const AlertDialogWid({super.key, required this.list});

  @override
  State<AlertDialogWid> createState() => _AlertDialogWidState();
}

class _AlertDialogWidState extends State<AlertDialogWid> {
  final LocalService _localService = LocalService();
  TextEditingController price = TextEditingController();
  TextEditingController count = TextEditingController();
  TextEditingController dolar = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late String ilkDeger;
  String? kod;
  int _currentStep = 0;
  @override
  void initState() {
    ilkDeger = widget.list[1].fonAdi!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: globalKey,
        child: AlertDialog(
          actionsOverflowDirection: VerticalDirection.up,
          title: Text(
            "Fon Bilgileri",
            style: AppConstants.moneyTs,
            textScaleFactor: 0.4,
          ),
          backgroundColor: AppConstants.secondaryColor,
          content: SizedBox(
            height: 400,
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fon Adı:",
                  style: AppConstants.moneyTs,
                  textScaleFactor: 0.3,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(16)),
                  child: SearchableDropdown(
                    trailingClearIcon: Container(),
                    value: ilkDeger,
                    isDialogExpanded: true,
                    isEnabled: true,
                    margin: const EdgeInsets.all(15),
                    items: widget.list
                        .map((e) => SearchableDropdownMenuItem(
                              label: e.fonKodu!,
                              onTap: () => kod = e.fonKodu,
                              value: e.fonAdi,
                              child: Text(
                                "${e.fonKodu!}: ${e.fonAdi!}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      ilkDeger = value!;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 300,
                  child: Stepper(
                    currentStep: _currentStep,
                    onStepTapped: (value) => setState(() {
                      _currentStep = value;
                    }),
                    controlsBuilder: (context, details) => _currentStep < 2
                        ? TextButton(
                            onPressed: () => setState(() {
                              _currentStep < 2 ? _currentStep++ : null;
                            }),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "Devam et",
                                style: AppConstants.moneyTs,
                                textScaleFactor: 0.26,
                              ),
                            ),
                          )
                        : Container(),
                    steps: [
                      step("Alış Fiyatı", price.text, 0, "", price),
                      step("Dolar Alış Kuru", dolar.text, 1,
                          "Fonu aldığınız günün dolar kurunu giriniz", dolar),
                      step("Adet", count.text, 2, "", count),
                    ],
                  ),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "Kaydet",
                style: AppConstants.moneyTs,
                textScaleFactor: 0.3,
              ),
              onPressed: () async {
                final form = globalKey.currentState;

                if (form!.validate()) {
                  List<LocaleDataModel> list = await _localService.getAllList();

                  bool check = false;
                  int? index;
                  index = list.indexWhere((element) => element.fonKodu == kod);

                  list.forEach((element) {
                    if (element.fonKodu == kod) {
                      check = true;
                    }
                  });

                  if (check) {
                    var updateData = LocaleDataModel.addData(
                      id: list[index].id!,
                      fiyat: fiyat(list[index]),
                      adet: adet(list[index]),
                      fonAdi: ilkDeger,
                      fonKodu: kod,
                      dolar: dolars(list[index]),
                    );
                    await _localService.updatePortfolio(
                        list[index].id!, updateData);
                  } else {
                    var newData = LocaleDataModel.addData(
                      id: const Uuid().v1(),
                      fiyat: price.text,
                      adet: count.text,
                      fonAdi: ilkDeger,
                      fonKodu: kod,
                      dolar: dolar.text,
                    );
                    await _localService.addPortfolio(newData);
                  }

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const HomePage(); // Sayfanın adını ve yapısını buraya ekleyin
                  }));
                }
              },
            ),
            TextButton(
              child: Text(
                "İptal Et",
                style: AppConstants.moneyTs,
                textScaleFactor: 0.3,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Step step(String? title, String? textFieldText, int? index, String? subTitle,
      TextEditingController con) {
    return Step(
      title: Text(title!),
      subtitle: Text(subTitle!),
      content: TextFormField(
          controller: con,
          validator: (value) {
            if (textFieldText == "") {
              setState(() {
                _currentStep = index!;
              });
              return "Lütfen bir değer giriniz";
            }
            return null;
          },
          keyboardType: const TextInputType.numberWithOptions(signed: true),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,4}')),
          ],
          decoration: const InputDecoration(border: OutlineInputBorder()),
          onFieldSubmitted: (value) => textFieldText = value),
    );
  }

  String fiyat(LocaleDataModel data) {
    return (
      (double.parse(data.maliyet!) +
              (double.parse(count.text) * double.parse(price.text))) /
          (double.parse(data.adet!) + double.parse(count.text)),
    ).toString();
  }

  String adet(LocaleDataModel data) {
    return (double.parse(count.text) + double.parse(data.adet!)).toString();
  }

  String dolars(LocaleDataModel data) {
    return ((double.parse(data.dolarMaliyet!) +
                (double.parse(count.text) * double.parse(dolar.text))) /
            (double.parse(data.adet!) + double.parse(count.text)))
        .toString();
  }
}
