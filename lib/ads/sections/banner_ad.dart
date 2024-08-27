import 'package:dri_learn/features/authentication/domain/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '/../core/di/injection_container.dart' as di;

void loadAd({required void Function(Ad) onAdLoaded, AdSize? adSize}) {
  final bannerAd = BannerAd(
    size: adSize ?? AdSize.largeBanner,
    adUnitId: "ca-app-pub-8953033025026599/2079571372",
    request: const AdRequest(nonPersonalizedAds: true),
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
  bool isConsentAllowed = di.sl<AuthRepository>().isConsentAllowed();
  print(isConsentAllowed);
  if (isConsentAllowed) {
    bannerAd.load();
  }
}
