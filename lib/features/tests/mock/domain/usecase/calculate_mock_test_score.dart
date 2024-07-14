import 'package:dri_learn/features/tests/core/domain/answer_model.dart';
import 'package:dri_learn/features/tests/mock/presentation/utils/test_ui_utils.dart';

class TestScoreInfo {
  final int score;
  final Grade grade;

  TestScoreInfo({required this.score, required this.grade});
}

class CalculateMockTestScore {
  TestScoreInfo call(Map<String, AnswerModel> answers) {
    var count = 0;
    answers.forEach((key, value) {
      if (value.userAnswer == value.question.answer) {
        count++;
      }
    });
    Grade grade;
    var ratio = count / answers.length;
    if (ratio > 0.8) {
      grade = Grade.Excellent;
    } else if (ratio < 0.5) {
      grade = Grade.Poor;
    } else {
      grade = Grade.Medium;
    }

    return TestScoreInfo(score: count, grade: grade);
  }
}
