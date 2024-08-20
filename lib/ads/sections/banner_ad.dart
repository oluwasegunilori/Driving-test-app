import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void loadAd({required void Function(Ad) onAdLoaded, AdSize? adSize}) {
  final bannerAd = BannerAd(
    size: adSize ?? AdSize.largeBanner,
    adUnitId: "ca-app-pub-3940256099942544/6300978111",
    request: const AdRequest(),
    listener: BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (ad) {
        onAdLoaded(ad);
      },
      // Called when an ad request failed.
      onAdFailedToLoad: (ad, error) {
        debugPrint('BannerAd failed to load: $error');
        ad.dispose();
      },
    ),
  );

  // Start loading.
  bannerAd.load();
}
