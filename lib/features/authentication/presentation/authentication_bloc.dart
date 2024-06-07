// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:dri_learn/core/domain/usecase/get_currrent_user_usecase.dart';
import 'package:dri_learn/features/authentication/domain/model/user_entity.dart';
import 'package:dri_learn/features/authentication/domain/usecase/google_signin_usecase.dart';
import 'package:dri_learn/features/authentication/domain/usecase/save_user_data_usecase.dart';
import 'package:dri_learn/features/authentication/presentation/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleSignInUseCase _googleSignInUseCase;

  final SaveUserDataUsecase _saveUserDataUsecase;

  final GetCurrentUserUseCase _getCurrentUserUseCase;

  AuthBloc(this._googleSignInUseCase, this._saveUserDataUsecase,
      this._getCurrentUserUseCase)
      : super(Initial()) {
    _getCurrentUserUseCase().listen((user) {
      emit(Done(user: user));
    });
    on<AuthEvent>((event, emit) async {
      if (event is GoogleSignInRequested) {
        final response = await _googleSignInUseCase();
        response.fold((error) => {emit(Error(error))},
            (data) => {emit(Done(user: data))});
      } else if (event is SkipSignIn) {
        _saveUserDataUsecase(User.noSignIn());
      }
    });
  }
}
