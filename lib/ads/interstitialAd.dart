import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:tefas_app/ads/adId.dart';
final interAd = StateProvider<int>((ref) => 0);


class InterstitialAds {
  static AdRequest request = const AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  InterstitialAd? _interstitialAd;
  int numInterstitialLoadAttempts = 0;

  //Geçiş Reklamı Reklam Oluşturma İsteği
  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdId.interId,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            debugPrint('$ad yüklendi');
            _interstitialAd = ad;
            numInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (
            LoadAdError error,
          ) {
            debugPrint("Yüklenmedi");
          },
        ));
  }

  //Geçiş Reklamı Gösterme İsteği
  void showInterstitialAd() {
    if (_interstitialAd == null) {
      debugPrint('Warning: attempt to show interstitial before loaded.');
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          debugPrint('Reklam ekrana geldi'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        debugPrint('$ad reklam ekrandan gitti');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        debugPrint("Gösterilmedi");
        ad.dispose();
        createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }
}
