import 'package:dri_learn/features/tests/core/domain/answer_model.dart';

class CalculateMockTestScore {
  int call(Map<String, AnswerModel> answers) {
    var count = 0;
    answers.forEach((key, value) {
      if (value.userAnswer == value.question.answer) {
        count++;
      }
    });
    return count;
  }
}
