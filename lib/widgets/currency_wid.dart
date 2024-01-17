import 'package:flutter/material.dart';
import 'package:tefas_app/constants/color_constant.dart';
import 'package:tefas_app/models/gheet_data_model.dart';

class CurrencyWid extends StatelessWidget {
  final List<DataGsheetsData> data;
  const CurrencyWid({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: currencyCol(context, 'USD', data[0].dolar!),
        ),
        Container(
          height: 20,
          width: 1,
          color: Clr.primary,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: currencyCol(context, 'EUR', data[0].eur!),
        ),
        Container(
          height: 20,
          width: 1,
          color: Clr.primary,
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: currencyCol(context, 'GBP', data[0].sterlin!),
        ),
        Container(
          height: 20,
          width: 1,
          color: Clr.primary,
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: currencyCol(context, 'BIST', data[0].bist!),
        ),
        Container(
          height: 20,
          width: 1,
          color: Clr.primary,
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: currencyCol(context, 'BTC', data[0].btc!, curren: '\$'),
        ),
      ],
    );
  }

  Column currencyCol(BuildContext context, String label, String data,
      {String curren = '₺'}) {
    return Column(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        Text(
          '${double.parse(data).toStringAsFixed(2)}$curren',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
