// mock_test_bloc.dart

import 'package:dri_learn/features/history/domain/usecase/save_test_history_usecase.dart';
import 'package:dri_learn/features/tests/core/domain/model/test_type.dart';
import 'package:dri_learn/features/tests/core/domain/repository/questions_repository.dart';
import 'package:dri_learn/features/tests/mock/domain/usecase/calculate_mock_test_score.dart';
import 'package:dri_learn/features/tests/mock/presentation/utils/test_ui_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/domain/model/answer_model.dart';
import '../../core/domain/model/question_model.dart';
import 'mock_test_event.dart';
import 'mock_test_state.dart';

class MockTestBloc extends Bloc<MockTestEvent, MockTestState> {
  final CalculateMockTestScore calculateMockTestScore;
  final QuestionsRepository questionsRepository;
  final SaveTestHistoryUsecase saveTestHistoryUsecase;
  TestType _testType = TestType.MockTest;
  MockTestBloc(
      {required this.calculateMockTestScore,
      required this.questionsRepository,
      required this.saveTestHistoryUsecase})
      : super(TestInitial()) {
    resetQuestions();

    on<SubmitAnswerEvent>((event, emit) {
      if (state is TestLoaded) {
        TestLoaded currentState = state as TestLoaded;
        if (currentState.viewMode) {
          if (!currentState.isOnLastQuestion()) {
            emit(currentState.copyWith(
                currentPosition: event.goToNextQuestion
                    ? currentState.currentPosition + 1
                    : currentState.currentPosition));
          }
          return;
        }
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
              TestScoreInfo info =
                  calculateMockTestScore.call(currentState.answers);
              emit(currentState.copyWith(testScoreInfo: info));
              saveTestHistoryUsecase.call(currentState.answers, _testType);
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
            currentPosition: currentState.currentPosition - 1,
          ));
        }
      }
    });

    on<SetViewModeEvent>((event, emit) {
      if (state is TestLoaded) {
        TestLoaded currentState = state as TestLoaded;
        emit(currentState.copyWith(currentPosition: 0, viewMode: true));
      }
    });
    on<LoadTestEvent>((event, emit) {
      resetQuestions();
    });
    on<SetTestType>((event, emit) {
      _testType = event.testType;
      resetQuestions();
    });
    on<ClearStateEvent>((event, emit) {
      resetQuestions();
    });

    on<NavigateToQuestionEvent>((event, emit) {
      if (state is TestLoaded) {
        TestLoaded currentState = state as TestLoaded;
        emit(currentState.copyWith(currentPosition: event.questionNo));
      }
    });
  }

  void resetQuestions() async {
    List<QuestionModel> questions =
        await questionsRepository.getQuestions(type: _testType);
    emit(TestLoaded(
        questions: questions,
        answers: const {},
        currentPosition: 0,
        viewMode: false,
        info: TestScoreInfo(score: 0, grade: Grade.Excellent)));
  }

  bool isMock() {
    return _testType == TestType.MockTest;
  }

  String getCurrentTestType() {
    return _testType.value;
  }
}
