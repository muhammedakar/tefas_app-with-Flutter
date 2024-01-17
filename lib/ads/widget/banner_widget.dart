import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../bannerAd.dart';

class BannerAdWid extends StatefulWidget {
  const BannerAdWid({super.key});

  @override
  State<BannerAdWid> createState() => _BannerTemplateExampleState();
}

class _BannerTemplateExampleState extends State<BannerAdWid> {
  late final BannerAds bannerAds;

  @override
  void initState() {
    bannerAds = BannerAds();
    bannerAds.myBanner.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 0),
      alignment: Alignment.center,
      width: bannerAds.myBanner.size.width.toDouble(),
      height: bannerAds.myBanner.size.height.toDouble(),
      child: AdWidget(ad: bannerAds.myBanner),
    );
  }
}
