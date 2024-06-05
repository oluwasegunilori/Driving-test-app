import 'dart:async';

import 'package:dri_learn/core/errors/errors.dart';
import 'package:dri_learn/features/authentication/domain/auth_repository.dart';
import 'package:dri_learn/features/authentication/domain/google_signin_usecase.dart';
import 'package:dri_learn/features/authentication/presentation/authentication_state.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleSignInUseCase
      _googleSignInUseCase; // Replace with your authentication repository

  AuthBloc(this._googleSignInUseCase) : super(Initial()) {
    on<AuthEvent>((event, emit) async {
      if (event is GoogleSignInRequested) {
        emit(Loading());
        final response = await _googleSignInUseCase();
        response.fold((error) => {emit(Error(error))},
            (data) => {emit(Done(user: data))});
      }
    });
  }
}
