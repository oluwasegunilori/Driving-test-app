import 'package:ontario_g1_test_2024/features/tests/core/domain/model/question_model.dart';
import 'package:equatable/equatable.dart';

class AnswerModel extends Equatable {
  final QuestionModel question;
  final int userAnswer;

  const AnswerModel({required this.question, required this.userAnswer});

  @override
  List<Object?> get props => [question, userAnswer];
}
