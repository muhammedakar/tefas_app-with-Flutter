import 'package:flutter/material.dart';
import 'package:tefas_app/constants/color_constant.dart';
import 'package:tefas_app/models/gheet_data_model.dart';

class TopRisersWid extends StatelessWidget {
  final bool sort;

  const TopRisersWid({super.key, required this.result, required this.sort});

  final List<DataGsheetsData>? result;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(bottom: 100),
        itemCount: 10,
        itemBuilder: (context, index) {
          siralamaKosul();
          DataGsheetsData data = result![index];

          return ListTile(
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Clr.primary,
              ),
              child: Text(
                data.fonKodu!,
                style: TextStyle(color: Clr.primary.shade50),
              ),
            ),
            title: Text(
              data.fonAdi!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Column(
              children: [
                Text(
                  '%${double.parse(data.gunluk!).toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: double.parse(data.gunluk!) <= 0
                            ? Colors.red
                            : Colors.green,
                      ),
                ),
              ],
            ),
          );
        });
  }

  void siralamaKosul() {
    if (!sort) {
      result!.sort(
        (a, b) => double.parse(a.gunluk!).compareTo(double.parse(b.gunluk!)),
      );
    } else {
      result!.sort(
        (a, b) => double.parse(b.gunluk!).compareTo(double.parse(a.gunluk!)),
      );
    }
  }
}
