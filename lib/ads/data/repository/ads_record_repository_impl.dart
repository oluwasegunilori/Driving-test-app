import 'package:ontario_g1_test_2024/ads/domain/repository/ads_record_repository.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

const interstitialAdsCount = "INSTADSCOUNT:DATA";
const maxCountToShowInterstitial = 3;

class AdsRecordRepositoryImpl extends AdsRecordRepository {
  final StreamingSharedPreferences _pfDb;

  AdsRecordRepositoryImpl(StreamingSharedPreferences pfDb) : _pfDb = pfDb;

  @override
  bool canShowInterStitial() {
    int value = _pfDb
        .getInt(interstitialAdsCount, defaultValue: maxCountToShowInterstitial)
        .getValue();
    _updateInstAdsCount(value);
    return value >= maxCountToShowInterstitial;
  }

  _updateInstAdsCount(int value) {
    if (value < maxCountToShowInterstitial) {
      _pfDb.setInt(interstitialAdsCount, value + 1);
    } else {
      _pfDb.setInt(interstitialAdsCount, 0);
    }
  }
}
