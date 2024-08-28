import 'package:ontario_g1_test_2024/features/tests/core/domain/model/answer_model.dart';
import 'package:equatable/equatable.dart';

class GemQuestionAnswerModel extends Equatable {
  final AnswerModel answerModel;
  final String? gemAnswer;

  const GemQuestionAnswerModel(
      {required this.answerModel, required this.gemAnswer});

  @override
  List<Object?> get props => [answerModel, gemAnswer];

  GemQuestionAnswerModel copyWith(
      {AnswerModel? answerModel, String? gemAnswer}) {
    return GemQuestionAnswerModel(
        answerModel: answerModel ?? this.answerModel,
        gemAnswer: gemAnswer ?? this.gemAnswer);
  }
}
