import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tefas_app/ads/adId.dart';

final rewardAd = StateProvider<int>((ref) => 0);

class RewardedAds {
  RewardedAd? _rewardedAd;

  final adUnitId = AdId.rewardId;

  /// Loads a rewarded ad.
  void loadAd() {
    RewardedAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _rewardedAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedAd failed to load: $error');
          },
        ));
  }

  void rewardedShow() {
    if (_rewardedAd == null) {
      debugPrint('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdClicked: (ad) => print('reklama tiklandi'),
      onAdDismissedFullScreenContent: (ad) {
        debugPrint('$ad reklam ekrandan gitti');
        ad.dispose();
        loadAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        debugPrint("Gösterilmedi");
        ad.dispose();
        loadAd();
      },
      onAdImpression: (ad) => print('reklam olustu'),
      onAdWillDismissFullScreenContent: (ad) => print('calisti'),
      onAdShowedFullScreenContent: (ad) => print('akar'),
    );
    _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {},
    );
  }
}
