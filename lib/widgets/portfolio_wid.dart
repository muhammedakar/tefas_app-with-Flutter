import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tefas_app/ads/interstitialAd.dart';
import 'package:tefas_app/constants/color_constant.dart';
import 'package:tefas_app/mixin/portfolio_mix.dart';
import 'package:tefas_app/models/gheet_data_model.dart';
import 'package:tefas_app/models/locale_data_model.dart';

class PortfolioWid extends ConsumerStatefulWidget {
  const PortfolioWid(
      {super.key, required this.result, required this.portfolio});
  final List<DataGsheetsData> result;
  final List<LocaleDataModel> portfolio;

  @override
  ConsumerState<PortfolioWid> createState() => _PortfolioWidState();
}

class _PortfolioWidState extends ConsumerState<PortfolioWid> with PortfolioMix {
  @override
  Widget build(BuildContext context) {
    if (widget.portfolio.isNotEmpty) {
      return ListView.builder(
          padding: const EdgeInsets.only(bottom: 100),
          itemCount: widget.portfolio.length,
          itemBuilder: (context, index) {
            LocaleDataModel data = widget.portfolio[index];
            int indexOfkod = widget.result
                .indexWhere((element) => element.fonKodu == data.fonKodu);
            double suankideger = double.parse(data.adet!) *
                double.parse(widget.result[indexOfkod].fiyat!);
            double suankidolardeger =
                suankideger / double.parse(widget.result[indexOfkod].dolar!);

            return ListTileTheme(
              child: ExpansionTile(
                onExpansionChanged: (c) {
                  if (c == true) {
                    if (ref.watch(interAd.state).state == 0) {
                      interstitialAds.showInterstitialAd();
                      ref.read(interAd.state).state++;
                    } else if (ref.watch(interAd.state).state == 2) {
                      ref.read(interAd.state).state = 0;
                    } else {
                      ref.read(interAd.state).state++;
                    }
                  }
                },
                collapsedIconColor: Clr.primary,
                tilePadding: const EdgeInsets.all(0),
                title: ListTile(
                  onLongPress: () => showDeleteDialog(data.id!),
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
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          data.fonAdi!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 12),
                        height: 40,
                        width: 65,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            double.parse(widget.result[indexOfkod].gunluk!) <= 0
                                ? const Icon(Icons.arrow_drop_down_rounded,
                                    color: Colors.red)
                                : const Icon(
                                    Icons.arrow_drop_up_rounded,
                                    color: Colors.green,
                                  ),
                            Expanded(
                              child: Text(
                                '%${double.parse(widget.result[indexOfkod].gunluk!).toStringAsFixed(2)}',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: double.parse(widget
                                                  .result[indexOfkod]
                                                  .gunluk!) <=
                                              0
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        portfolioCol(context, 'Adet:', data.adet!),
                        portfolioCol(
                          context,
                          'Alış Fiyatı:',
                          data.fiyat!,
                          trailing: '₺',
                        ),
                        portfolioCol(
                          context,
                          'Anlık Fiyat:',
                          double.parse(widget.result[indexOfkod].fiyat!)
                              .toStringAsFixed(2),
                          trailing: '₺',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        portfolioCol(
                          context,
                          'Maliyet:',
                          double.parse(data.maliyet!).toStringAsFixed(2),
                          trailing: '₺',
                        ),
                        portfolioCol(
                          context,
                          'Maliyet (\$):',
                          double.parse(data.dolarMaliyet!).toStringAsFixed(2),
                          trailing: '\$',
                        ),
                        portfolioCol(
                          context,
                          'Değişim:',
                          '%${degisim(suankideger, data.maliyet!)}',
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      portfolioCol(
                        context,
                        'Kazanç:',
                        kazanc([suankideger, data.maliyet!]),
                        trailing: '₺',
                      ),
                      portfolioCol(
                        context,
                        'Kazanç (\$):',
                        kazanc([suankidolardeger, data.dolarMaliyet!]),
                        trailing: '\$',
                      ),
                      portfolioCol(
                        context,
                        'Değer:',
                        suankideger.toStringAsFixed(2),
                        trailing: '₺',
                      ),
                      portfolioCol(
                        context,
                        'Değer (\$):',
                        suankidolardeger.toStringAsFixed(2),
                        trailing: '\$',
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 10),
        child: Center(
            child: Text(
          "Porföyünüzde fon bulunmamaktadır.",
          maxLines: 1,
          style: Theme.of(context).textTheme.bodyLarge,
        )),
      );
    }
  }
}
