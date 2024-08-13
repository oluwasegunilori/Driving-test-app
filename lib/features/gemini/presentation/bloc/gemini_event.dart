part of 'gemini_bloc.dart';

sealed class GeminiEvent extends Equatable {
  const GeminiEvent();

  @override
  List<Object> get props => [];
}

class FetchResultEvent extends GeminiEvent {
  const FetchResultEvent();

  @override
  List<Object> get props => [];
}
