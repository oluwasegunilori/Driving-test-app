import 'package:dri_learn/features/tests/description/domain/model/question_type_model.dart';
import 'package:equatable/equatable.dart';

class QuestionModel extends Equatable {
  final String question;
  final List<String> options;
  final String? image;
  final int answer;
  final QuestionType questionType;

  const QuestionModel(
      {required this.question,
      required this.options,
      this.image,
      required this.answer,
      required this.questionType});

  @override
  List<Object?> get props => [question, options, image, answer, questionType];
}
