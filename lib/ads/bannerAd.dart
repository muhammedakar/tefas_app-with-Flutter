
import "package:flutter/foundation.dart";
import "package:google_mobile_ads/google_mobile_ads.dart";
import "package:tefas_app/ads/adId.dart";

class BannerAds {
  BannerAd myBanner = BannerAd(
    adUnitId: AdId.bannerId,
    size: AdSize.banner,
    request: const AdRequest(),
    listener: BannerAdListener(
      onAdFailedToLoad: (ad, error) async {
        // show = false;
        ad.dispose();
      },
      onAdLoaded: (ad) {
        debugPrint("Reklam yüklendi");
      },
    ),
  );
}
