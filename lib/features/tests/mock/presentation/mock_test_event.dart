import 'package:dri_learn/features/tests/core/domain/answer_model.dart';
import 'package:dri_learn/features/tests/core/domain/question_type_model.dart';
import 'package:equatable/equatable.dart';

abstract class MockTestEvent extends Equatable {
  const MockTestEvent();

  @override
  List<Object> get props => [];
}

class LoadTestEvent extends MockTestEvent {}

class SubmitAnswerEvent extends MockTestEvent {
  final AnswerModel answer;
  final bool goToNextQuestion;

  const SubmitAnswerEvent(this.answer, {this.goToNextQuestion = true});

  @override
  List<Object> get props => [answer];
}

class PreviousQuestEvent extends MockTestEvent {}

class SetViewModeEvent extends MockTestEvent {}

class SetQuestionType extends MockTestEvent {
  final QuestionType? questionType;

  const SetQuestionType({required this.questionType});
}
