import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tefas_app/pages/add_fon_page.dart';
import 'package:uuid/uuid.dart';

import '../ads/rewardedAd.dart';
import '../models/locale_data_model.dart';
import '../pages/home_page.dart';
import '../service/locale_service.dart';

mixin AddFonPageMix on State<AddFonPage> {
  late String ilkDeger;
  final LocalService localService = LocalService();
  TextEditingController price = TextEditingController();
  TextEditingController count = TextEditingController();
  TextEditingController dolar = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final RewardedAds rewardedAds = RewardedAds();

  String? kod;
  @override
  void initState() {
    ilkDeger = widget.list[1].fonAdi!;
    rewardedAds.loadAd();
    super.initState();
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

  void saveButton() async {
    final form = globalKey.currentState;
    kod ??= 'AAL';

    if (form!.validate()) {
      List<LocaleDataModel> list = await localService.getAllList();

      bool check = false;
      int? index;
      index = list.indexWhere((element) => element.fonKodu == kod);

      for (var element in list) {
        if (element.fonKodu == kod) {
          check = true;
        }
      }

      if (check) {
        var updateData = LocaleDataModel.addData(
          id: list[index].id!,
          fiyat: fiyat(list[index]),
          adet: adet(list[index]),
          fonAdi: ilkDeger,
          fonKodu: kod,
          dolar: dolars(list[index]),
        );
        await localService.updatePortfolio(list[index].id!, updateData);
      } else {
        var newData = LocaleDataModel.addData(
          id: const Uuid().v1(),
          fiyat: price.text,
          adet: count.text,
          fonAdi: ilkDeger,
          fonKodu: kod,
          dolar: dolar.text,
        );
        await localService.addPortfolio(newData);
      }
      


      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
        return const HomePage(); // Sayfanın adını ve yapısını buraya ekleyin
      }));
    }
  }

  String? validate() {
    if (dolar.text == '') {
      return "Lütfen bir değer giriniz";
    }
    return null;
  }

  Container textformWid(TextEditingController con) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
          controller: con,
          validator: (value) => validate(),
          keyboardType: const TextInputType.numberWithOptions(signed: true),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,4}')),
          ],
          decoration: const InputDecoration(border: InputBorder.none),
          onChanged: (value) => con.text = value,
          onFieldSubmitted: (value) => con.text = value),
    );
  }
}
