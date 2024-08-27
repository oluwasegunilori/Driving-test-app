import 'package:dri_learn/features/authentication/domain/repository/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

const consentAllowed = "Consent_Allwoed";

class AuthRepositoryImpl extends AuthRepository {
  final StreamingSharedPreferences sharedPreferences;

  AuthRepositoryImpl({required this.sharedPreferences});
  @override
  Future<UserCredential> googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  void updateConsentAllowed(bool value) {
    sharedPreferences.setBool(consentAllowed, value);
  }

  @override
  bool isConsentAllowed() {
    bool result = sharedPreferences
        .getBool(consentAllowed, defaultValue: false)
        .getValue();
    return result;
  }
}
