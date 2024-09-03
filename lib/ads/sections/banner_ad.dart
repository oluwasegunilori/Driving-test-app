import 'dart:io';

import 'package:ontario_g1_test_2024/ads/domain/repository/ads_record_repository.dart';
import 'package:ontario_g1_test_2024/features/authentication/domain/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '/../core/di/injection_container.dart' as di;

void loadAd({required void Function(Ad) onAdLoaded, AdSize? adSize}) {
  bool isConsentAllowed = di.sl<AuthRepository>().isConsentAllowed();
  final bannerAd = BannerAd(
    size: adSize ?? AdSize.largeBanner,
    adUnitId: Platform.isAndroid
        ? "ca-app-pub-8953033025026599/4895175089"
        : "ca-app-pub-8953033025026599/9126790480",
    request: AdRequest(nonPersonalizedAds: !isConsentAllowed),
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
  if (isConsentAllowed) {
    bannerAd.load();
  }
}

/// Loads an interstitial ad.
void loadInstAd() {
  bool isConsentAllowed = di.sl<AuthRepository>().isConsentAllowed();
  bool canShowInterstitial = di.sl<AdsRecordRepository>().canShowInterStitial();
  if (!isConsentAllowed || !canShowInterstitial) {
    return;
  }
  InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? "ca-app-pub-8953033025026599/6829855663"
          : "ca-app-pub-8953033025026599/3529739059",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          // Keep a reference to the ad so you can show it later.
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
        },
      ));
}
