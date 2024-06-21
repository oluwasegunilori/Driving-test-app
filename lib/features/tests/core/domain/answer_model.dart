import 'package:dri_learn/features/tests/core/domain/question_model.dart';
import 'package:equatable/equatable.dart';

class AnswerModel extends Equatable {
  final QuestionModel question;
  final int userAnswer;

  const AnswerModel({required this.question, required this.userAnswer});

  @override
  List<Object?> get props => [question.id];
}
