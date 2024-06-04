// onboarding_bloc.dart
// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingInitial());

  @override
  void onEvent(OnboardingEvent event) {
    super.onEvent(event);
    if (state is OnboardingInitial) {
      if (event is NextPageEvent) {
        emit(OnboardingInitial(
            currentPage: (state as OnboardingInitial).currentPage + 1));
      } else if (event is PreviousPageEvent) {
        emit(OnboardingInitial(
            currentPage: (state as OnboardingInitial).currentPage - 1));
      } else if (event is SkipOnboardingEvent) {
        // Handle skip logic, maybe navigate to the home page
        emit(OnboardingInitial(
            currentPage: (state as OnboardingInitial).currentPage));
      }
    }
  }
}
