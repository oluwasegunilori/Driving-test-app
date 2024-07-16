import 'package:dri_learn/features/tests/core/domain/model/answer_model.dart';
import 'package:dri_learn/features/tests/core/domain/model/question_type_model.dart';
import 'package:dri_learn/features/tests/core/domain/model/test_type.dart';
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

class SetTestType extends MockTestEvent {
  final TestType? testType;

  const SetTestType({required this.testType});
}

class ClearStateEvent extends MockTestEvent {
}
