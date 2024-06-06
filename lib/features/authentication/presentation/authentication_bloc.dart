import 'dart:async';

import 'package:dri_learn/core/errors/errors.dart';
import 'package:dri_learn/features/authentication/domain/auth_repository.dart';
import 'package:dri_learn/features/authentication/domain/model/user_entity.dart';
import 'package:dri_learn/features/authentication/domain/usecase/google_signin_usecase.dart';
import 'package:dri_learn/features/authentication/domain/usecase/save_user_data_usecase.dart';
import 'package:dri_learn/features/authentication/presentation/authentication_state.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleSignInUseCase _googleSignInUseCase;

  final SaveUserDataUsecase _saveUserDataUsecase;

  AuthBloc(this._googleSignInUseCase, this._saveUserDataUsecase)
      : super(Initial()) {
    on<AuthEvent>((event, emit) async {
      if (event is GoogleSignInRequested) {
        emit(Loading());
        final response = await _googleSignInUseCase();
        response.fold((error) => {emit(Error(error))},
            (data) => {emit(Done(user: data))});
      } else if (event is SkipSignIn) {
        _saveUserDataUsecase(User.noSignIn());
      }
    });
  }
}
