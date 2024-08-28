import 'package:ontario_g1_test_2024/core/errors/errors.dart';
import 'package:ontario_g1_test_2024/features/authentication/domain/model/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class Initial extends AuthState {}

class Loading extends AuthState {}

class Done extends AuthState {
  final User? user; // Optional: Add user data or token if needed

  const Done({this.user});

  @override
  List<Object?> get props => [user];
}

class Error extends AuthState {
  final MessageException exception;

  const Error(this.exception);
}
