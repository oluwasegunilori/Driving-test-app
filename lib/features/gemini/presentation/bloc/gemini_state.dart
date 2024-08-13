part of 'gemini_bloc.dart';

abstract class GeminiState extends Equatable {
  const GeminiState();

  @override
  List<Object> get props => [];
}

final class GeminInitial extends GeminiState {
  @override
  List<Object> get props => [];
}

final class GeminiTextStreamer extends GeminiState {
  final String text;

  const GeminiTextStreamer({required this.text});
  @override
  List<Object> get props => [text,];
}
