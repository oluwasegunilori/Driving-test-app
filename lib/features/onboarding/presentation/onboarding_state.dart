// onboarding_state.dart
import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {
  final int currentPage;

  const OnboardingInitial({this.currentPage = 0});

  @override
  List<Object> get props => [currentPage];
}
