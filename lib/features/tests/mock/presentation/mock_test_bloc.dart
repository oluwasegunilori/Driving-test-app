// mock_test_bloc.dart
import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/domain/answer_model.dart';
import '../../core/domain/question_model.dart';
import 'mock_test_event.dart';
import 'mock_test_state.dart';

class MockTestBloc extends Bloc<MockTestEvent, MockTestState> {
  MockTestBloc() : super(TestInitial()) {
    emit(TestLoaded(
        questions: questionsStat, answers: const {}, currentPosition: 0));

    on<SubmitAnswerEvent>((event, emit) {
      if (state is TestLoaded) {
        TestLoaded currentState = state as TestLoaded;
        if (currentState.currentPosition < currentState.questions.length) {
          var answers = Map<String, AnswerModel>.from(currentState.answers);
          answers[currentState.getCurrentQuestion().id] = event.answer;
          if (currentState.currentPosition + 1 <
              currentState.questions.length - 1) {
            emit(TestLoaded(
                questions: currentState.questions,
                answers: answers,
                currentPosition: event.goToNextQuestion
                    ? currentState.currentPosition + 1
                    : currentState.currentPosition));
          }
        } else {
          print(currentState.answers);
          //Answer all answered
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
