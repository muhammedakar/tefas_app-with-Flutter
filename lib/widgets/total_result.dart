import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tefas_app/constants/color_constant.dart';
import 'package:tefas_app/mixin/total_result_mix.dart';
import 'package:tefas_app/models/gheet_data_model.dart';
import 'package:tefas_app/models/locale_data_model.dart';

class TotalResult extends StatefulWidget {
  final List<LocaleDataModel> portfolio;
  final List<DataGsheetsData> result;
  const TotalResult({super.key, required this.portfolio, required this.result});

  @override
  State<TotalResult> createState() => _TotalResultState();
}

class _TotalResultState extends State<TotalResult> with TotalResultMix {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Clr.primaryAccent,
            )),
        child: Row(
          children: [
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Clr.primary),
                    child: SvgPicture.asset(
                      'assets/images/tl.svg',
                      color: Clr.primary.shade50,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Toplam: ${loopsMethod().toStringAsFixed(2)} ₺',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Clr.primary),
                        ),
                        Text(
                          'Degisim: % ${degisim().toStringAsFixed(2)}',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Clr.primary),
                        ),
                        Text(
                          'Kazanc: ${kazanc().toStringAsFixed(2)} ₺',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Clr.primary),
                        ),
                        Text(
                          'Maliyet: ${maliyet().toStringAsFixed(2)} ₺',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Clr.primary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(width: 8),
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Clr.primary),
                    child: SvgPicture.asset(
                      'assets/images/dollar.svg',
                      color: Clr.primary.shade50,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Toplam: ${dolarTotal().toStringAsFixed(2)} \$',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Clr.primary),
                        ),
                        Text(
                          'Degisim: % ${degisimDolar().toStringAsFixed(2)}',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Clr.primary),
                        ),
                        Text(
                          'Kazanç: ${dolarKazanc().toStringAsFixed(2)} \$',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Clr.primary),
                        ),
                        Text(
                          'Maliyet: ${dolarMaliyet().toStringAsFixed(2)} \$',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Clr.primary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
