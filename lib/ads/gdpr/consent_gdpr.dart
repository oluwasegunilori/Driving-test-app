import 'package:user_messaging_platform/user_messaging_platform.dart';

void updateConsent({required Function(bool) callback}) async {
  // Make sure to continue with the latest consent info.
  var info = await UserMessagingPlatform.instance.requestConsentInfoUpdate();

  // Show the consent form if consent is required.
  if (info.consentStatus == ConsentStatus.required) {
    // `showConsentForm` returns the latest consent info, after the consent from has been closed.
    info = await UserMessagingPlatform.instance.showConsentForm();
    if (info.consentStatus == ConsentStatus.obtained) {
      callback(true);
    } else {
      callback(false);
    }
  } else {
    callback(true);
  }
}
