// mock_test_state.dart
import 'package:dri_learn/features/tests/core/domain/model/answer_model.dart';
import 'package:dri_learn/features/tests/mock/domain/usecase/calculate_mock_test_score.dart';
import 'package:dri_learn/features/tests/mock/presentation/utils/test_ui_utils.dart';
import 'package:equatable/equatable.dart';

import '../../core/domain/model/question_model.dart';

abstract class MockTestState extends Equatable {
  const MockTestState();

  @override
  List<Object> get props => [];
}

class TestInitial extends MockTestState {}

class TestLoading extends MockTestState {}

class TestLoaded extends MockTestState {
  final List<QuestionModel> questions;
  final Map<String, AnswerModel> answers;
  final int currentPosition;
  final bool viewMode;
  final TestScoreInfo info;

  const TestLoaded({
    required this.questions,
    required this.answers,
    required this.currentPosition,
    required this.viewMode,
    required this.info,
  });

  TestLoaded copyWith({
    List<QuestionModel>? questions,
    Map<String, AnswerModel>? answers,
    int? currentPosition,
    bool? viewMode,
    TestScoreInfo? testScoreInfo,
  }) {
    return TestLoaded(
      questions: questions ?? this.questions,
      answers: answers ?? this.answers,
      currentPosition: currentPosition ?? this.currentPosition,
      viewMode: viewMode ?? this.viewMode,
      info: testScoreInfo ?? info,
    );
  }

  QuestionModel getCurrentQuestion() {
    return questions[currentPosition];
  }

  bool isOnLastQuestion() => currentPosition == questions.length - 1;

  @override
  List<Object> get props =>
      [questions, answers, currentPosition, viewMode, info];
}

class AnswerSubmitted extends MockTestState {
  final int questionId;
  final String answer;

  const AnswerSubmitted(this.questionId, this.answer);

  @override
  List<Object> get props => [questionId, answer];
}

class TestError extends MockTestState {
  final String message;

  const TestError(this.message);

  @override
  List<Object> get props => [message];
}
