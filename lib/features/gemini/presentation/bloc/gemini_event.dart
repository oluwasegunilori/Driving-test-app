part of 'gemini_bloc.dart';

sealed class GeminiEvent extends Equatable {
  const GeminiEvent();

  @override
  List<Object> get props => [];
}

class FetchResultEvent extends GeminiEvent {
  final AnswerModel answerModel;
  const FetchResultEvent({required this.answerModel});

  @override
  List<Object> get props => [answerModel];
}
