import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class GoogleSignInRequested extends AuthEvent {}

class AppleSignInRequested extends AuthEvent {}

class SkipSignIn extends AuthEvent {}
