import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void loadAd({required void Function(Ad) onAdLoaded, AdSize? adSize}) {
  final bannerAd = BannerAd(
    size: adSize ?? AdSize.largeBanner,
    adUnitId: "ca-app-pub-8953033025026599/9126790480",
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
