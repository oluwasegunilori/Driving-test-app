// mock_test_bloc.dart
import 'dart:collection';

import 'package:dri_learn/features/tests/description/domain/model/question_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'mock_test_event.dart';
import 'mock_test_state.dart';

class MockTestBloc extends Bloc<MockTestEvent, MockTestState> {
  MockTestBloc() : super(TestInitial()) {
    emit(TestLoaded(
        questions: questionsStat, answers: const {}, currentPosition: 0));

    on<SubmitAnswerEvent>((event, emit) {
      if (state is TestLoaded) {
        TestLoaded currentState = state as TestLoaded;
        if (currentState.currentPosition + 1 < currentState.questions.length) {
          var answers = currentState.answers.toSet();
          answers.add(event.answer);
          emit(TestLoaded(
              questions: currentState.questions,
              answers: UnmodifiableSetView(answers),
              currentPosition: currentState.currentPosition + 1));
        } else {
          print(currentState.answers);
          //Answer all answered
        }
      }
    });
  }
}
