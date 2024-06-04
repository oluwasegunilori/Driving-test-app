import 'dart:async';

import 'package:dri_learn/features/authentication/domain/auth_repository.dart';
import 'package:dri_learn/features/authentication/presentation/authentication_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository
      _repository; // Replace with your authentication repository

  AuthBloc(this._repository) : super(Initial()) {
    on<AuthEvent>((event, emit) async {
      if (event is GoogleSignInRequested) {
        emit(Loading());
        try {
          final user = await _repository.googleSignIn();
          emit(Done(
              user: user.additionalUserInfo!
                  .username)); // Update with actual user data
        } catch (error) {
          emit(Error()); // Handle error with appropriate state
        }
      }
    });
  }
}
