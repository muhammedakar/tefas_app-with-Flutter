import 'package:flutter/material.dart';
import 'package:tefas_app/constants/app_constants.dart';
import 'package:tefas_app/constants/color_constant.dart';
import 'package:tefas_app/pages/home_page.dart';
import 'package:tefas_app/service/locale_service.dart';
import 'package:tefas_app/widgets/portfolio_wid.dart';

import '../ads/interstitialAd.dart';

mixin PortfolioMix on State<PortfolioWid> {
  final LocalService localService = LocalService();
  final InterstitialAds interstitialAds = InterstitialAds();
  @override
  void initState() {
    interstitialAds.createInterstitialAd();
    super.initState();
  }

  String kazanc(List? dolarOrTl) {
    return (dolarOrTl![0] - double.parse(dolarOrTl[1])).toStringAsFixed(2);
  }

  String degisim(double suankideger, String maliyet) {
    return ((suankideger - double.parse(maliyet)) / double.parse(maliyet) * 100)
        .toStringAsFixed(2);
  }

  Expanded portfolioCol(BuildContext context, String label, String value,
      {String trailing = ''}) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Clr.primary.shade300),
          ),
          Text(
            value + trailing,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Clr.primary, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  showDeleteDialog(String id) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
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
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ));
  }
}
