import 'package:dri_learn/features/history/domain/model/test_history_model.dart';
import 'package:dri_learn/features/history/domain/repository/test_history_repository.dart';
import 'package:dri_learn/features/tests/core/domain/model/answer_model.dart';
import 'package:uuid/uuid.dart';

class SaveTestHistoryUsecase {
  final TestHistoryRepository repository;

  SaveTestHistoryUsecase({required this.repository});

  Future<void> call(Map<String, AnswerModel> answers) async {
    List<String> missedQuestionIds = [];
    int count = 0;

    answers.forEach((key, value) {
      if (value.userAnswer == value.question.answer) {
        count++;
      } else {
        missedQuestionIds.add(value.question.id);
      }
    });
    TestHistoryModel model = TestHistoryModel(
        id: const Uuid().v4(),
        missedQuestionIds: missedQuestionIds,
        scoreRate: scoreRate,
        numberOfQuestions: numberOfQuestions,
        noOfCorrectAnswers: count,
        testType: testType,
        date: DateTime.now());
    repository.saveTest(model);
  }
}
