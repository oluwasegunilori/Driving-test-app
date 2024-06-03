// onboarding_event.dart
import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class NextPageEvent extends OnboardingEvent {}

class PreviousPageEvent extends OnboardingEvent {}

class SkipOnboardingEvent extends OnboardingEvent {}
