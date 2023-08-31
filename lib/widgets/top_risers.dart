import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tefas_app/models/gheet_data_model.dart';

import '../constants/app_constants.dart';

class TopRisersWid extends StatelessWidget {
  final bool sort;
  final List<DataGsheetsData> result;
  const TopRisersWid({super.key, required this.result, required this.sort});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190.w,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          siralamaKosul();
          DataGsheetsData data = result[index];
          return cardItembuilder(data);
        },
      ),
    );
  }

  Padding cardItembuilder(DataGsheetsData data) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: 0.5.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: firstRow(data),
              ),
              Expanded(
                flex: 2,
                child: secondRow(data),
              ),
              Expanded(
                flex: 1,
                child: thirdRow(data),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Align thirdRow(DataGsheetsData data) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Text(
        data.fonAdi!,
        style: AppConstants.bottomTs(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Row secondRow(DataGsheetsData data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "${double.parse(data.fiyat!).toStringAsFixed(2)} ₺",
            maxLines: 1,
            textScaleFactor: 0.4,
            style: AppConstants.moneyTs,
          ),
        ),
        const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 40,
          color: Colors.black,
        )
      ],
    );
  }

  Row firstRow(DataGsheetsData data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.black,
            ),
            child: Center(
                child: Text(
              data.fonKodu!,
              style: AppConstants.bottomTs(color: Colors.white),
            )),
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.topRight,
            child: Text(
              "%${double.parse(data.gunluk!).toStringAsFixed(2)}",
              style: AppConstants.bottomTs(
                color:
                    double.parse(data.gunluk!) > 0 ? Colors.green : Colors.red,
              ),
            ),
          ),
        )
      ],
    );
  }

  ///Bu fonksiyon gelen bool değerine göre günlük değerlere kıyasla sıralama yapıyor.
  void siralamaKosul() {
    if (!sort) {
      result.sort(
        (a, b) => double.parse(a.gunluk!).compareTo(double.parse(b.gunluk!)),
      );
    } else {
      result.sort(
        (a, b) => double.parse(b.gunluk!).compareTo(double.parse(a.gunluk!)),
      );
    }
  }
}
