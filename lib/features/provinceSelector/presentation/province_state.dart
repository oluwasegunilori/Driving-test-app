import 'package:equatable/equatable.dart';

import '../domain/model/province_model.dart';

// Abstract class representing the state of the form
abstract class ProvinceState extends Equatable {
  final Set<Province> selectedProvinces;
  const ProvinceState({this.selectedProvinces = const <Province>{}});

  @override
  List<Object?> get props => [selectedProvinces];
}

class InitialState extends ProvinceState {
  const InitialState();
}

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
  const DoneState({required this.provinces, super.selectedProvinces});

  DoneState copyWith(
      {List<Province>? provinces, Set<Province>? selectedProvinces}) {
    return DoneState(
        provinces: provinces ?? this.provinces,
        selectedProvinces: selectedProvinces ?? this.selectedProvinces);
  }

  @override
  List<Object?> get props => [provinces, selectedProvinces];
}

// Submitting state
class SubmittingState extends ProvinceState {
  SubmittingState();

  @override
  List<Object?> get props => [];
}

class DoneSubmittingState extends ProvinceState {
  DoneSubmittingState();

  @override
  List<Object?> get props => [];
}
