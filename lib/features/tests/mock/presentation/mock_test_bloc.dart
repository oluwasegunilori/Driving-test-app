// mock_test_bloc.dart
import 'dart:collection';

import 'package:dri_learn/features/tests/mock/domain/usecase/calculate_mock_test_score.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/domain/answer_model.dart';
import '../../core/domain/question_model.dart';
import 'mock_test_event.dart';
import 'mock_test_state.dart';

class MockTestBloc extends Bloc<MockTestEvent, MockTestState> {
  final CalculateMockTestScore calculateMockTestScore;
  MockTestBloc({required this.calculateMockTestScore}) : super(TestInitial()) {
    emit(TestLoaded(
        questions: questionsStat,
        answers: const {},
        currentPosition: 0,
        newViewMode: true));

    on<SubmitAnswerEvent>((event, emit) {
      if (state is TestLoaded) {
        TestLoaded currentState = state as TestLoaded;
        if (currentState.currentPosition < currentState.questions.length) {
          var answers = Map<String, AnswerModel>.from(currentState.answers);
          answers[currentState.getCurrentQuestion().id] = event.answer;
          if (currentState.currentPosition <=
              currentState.questions.length - 1) {
            emit(currentState.copyWith(
              questions: currentState.questions,
              answers: answers,
              currentPosition: event.goToNextQuestion
                  ? currentState.currentPosition + 1
                  : currentState.currentPosition,
            ));
            if (event.goToNextQuestion && currentState.isOnLastQuestion()) {
              //Answer all answered
              int score = calculateMockTestScore.call(currentState.answers);
              emit(currentState.copyWith(score: score));
            }
          }
        }
      }
    });

    on<PreviousQuestEvent>((event, emit) {
      if (state is TestLoaded) {
        TestLoaded currentState = state as TestLoaded;
        if (currentState.currentPosition > 0) {
          emit(currentState.copyWith(
              currentPosition: currentState.currentPosition - 1));
        }
      }
    });
  }

}
