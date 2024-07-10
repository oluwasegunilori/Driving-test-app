// mock_test_state.dart
import 'package:dri_learn/features/tests/core/domain/answer_model.dart';
import 'package:equatable/equatable.dart';

import '../../core/domain/question_model.dart';

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

  const TestLoaded(
      {required this.questions,
      required this.answers,
      required this.currentPosition});

  TestLoaded copyWith(
      {List<QuestionModel>? questions,
      Map<String, AnswerModel>? answers,
      int? currentPosition}) {
    return TestLoaded(
        questions: questions ?? this.questions,
        answers: answers ?? this.answers,
        currentPosition: currentPosition ?? this.currentPosition);
  }

  QuestionModel getCurrentQuestion() {
    return questions[currentPosition];
  }

  bool isOnLastQuestion() => currentPosition == questions.length -1;

  @override
  List<Object> get props => [questions, answers, currentPosition];
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
