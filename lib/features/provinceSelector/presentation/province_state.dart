import 'package:equatable/equatable.dart';

import '../domain/model/province_model.dart';

// Abstract class representing the state of the form
abstract class ProvinceState extends Equatable {
  const ProvinceState();

  @override
  List<Object?> get props => [];
}

class InitialState extends ProvinceState {}

// Loading state
class LoadingState extends ProvinceState {
  const LoadingState();

  @override
  List<Object?> get props => [];
}

// Error state
class ErrorState extends ProvinceState {
  final String errorMessage;

  const ErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

// Done state
class DoneState extends ProvinceState {
  final List<Province> provinces;
  const DoneState(this.provinces);

  @override
  List<Object?> get props => [provinces];
}

// Submitting state
class SubmittingState extends ProvinceState {
  const SubmittingState();

  @override
  List<Object?> get props => [];
}

class DoneSubmittingState extends ProvinceState {
  const DoneSubmittingState();

  @override
  List<Object?> get props => [];
}
