import 'package:flutter/material.dart';
import 'package:tefas_app/widgets/total_result.dart';

mixin TotalResultMix on State<TotalResult>{
  double loopsMethod() {
    double toplam = 0;

    for (int i = 0; i < widget.portfolio.length; i++) {
      int indexOfkod = widget.result.indexWhere(
        (element) => element.fonKodu == widget.portfolio[i].fonKodu,
      );
      toplam += double.parse(widget.portfolio[i].adet!) *
          double.parse(widget.result[indexOfkod].fiyat!);
    }
    return toplam;
  }

  double dolarTotal() {
    double toplam = 0;

    for (int i = 0; i < widget.portfolio.length; i++) {
      int indexOfkod = widget.result.indexWhere(
        (element) => element.fonKodu == widget.portfolio[i].fonKodu,
      );
      toplam += double.parse(widget.portfolio[i].adet!) *
          double.parse(widget.result[indexOfkod].fiyat!) /
          double.parse(widget.result[indexOfkod].dolar!);
    }
    return toplam;
  }

  double degisim() {
    double maliyetToplam = 0;
    for (int i = 0; i < widget.portfolio.length; i++) {
      maliyetToplam += double.parse(widget.portfolio[i].maliyet!);
    }

    return ((loopsMethod() - maliyetToplam) * 100) / maliyetToplam;
  }

  double kazanc() {
    double maliyetToplam = 0;
    for (int i = 0; i < widget.portfolio.length; i++) {
      maliyetToplam += double.parse(widget.portfolio[i].maliyet!);
    }

    return maliyetToplam * (degisim() / 100);
  }

  double dolarKazanc() {
    return dolarTotal() - dolarMaliyet();
  }

  double maliyet() {
    double maliyetToplam = 0;
    for (int i = 0; i < widget.portfolio.length; i++) {
      maliyetToplam += double.parse(widget.portfolio[i].maliyet!);
    }

    return maliyetToplam;
  }

  double dolarMaliyet() {
    double maliyetToplam = 0;
    for (int i = 0; i < widget.portfolio.length; i++) {
      maliyetToplam += double.parse(widget.portfolio[i].dolarMaliyet!);
    }

    return maliyetToplam;
  }

  double degisimDolar() {
    return dolarKazanc() * 100 / dolarMaliyet();
  }
}