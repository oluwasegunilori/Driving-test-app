part of 'gemini_bloc.dart';

sealed class GeminiState extends Equatable {
  const GeminiState();

  @override
  List<Object> get props => [];
}

final class GeminInitial extends GeminiState {
  @override
  List<Object> get props => [];
}

final class GeminiTextStreamer extends GeminiState {
  final List<GemQuestionAnswerModel> answerModel;

  const GeminiTextStreamer({required this.answerModel});
  @override
  List<Object> get props => [
        answerModel,
      ];

  GemQuestionAnswerModel? getByQuestionId(String id) {
    return answerModel
        .where((element) => element.answerModel.question.id == id)
        .firstOrNull;
  }
}
