import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential> googleSignIn();
  void updateConsentAllowed(bool value);
  bool isConsentAllowed();
}
