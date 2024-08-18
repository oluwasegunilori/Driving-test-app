import 'package:dri_learn/features/tests/core/domain/model/answer_model.dart';

class GenerateGeminiQuestionUsecase {
  String call(AnswerModel model) {
    String generateQuestion =
        "In ontario, ${model.question.question}. Why is the answer ";
    //If user got the question right
    if (model.question.answer == model.userAnswer) {
      generateQuestion += model.question.options[model.question.answer];
    }
    //User did not get the answer right
    else {
      generateQuestion +=
          "${model.question.options[model.question.answer]} and the answer shoul not be ${model.question.options[model.userAnswer]}";
    }
    if (model.question.geminiQuestion != null) {
      generateQuestion = model.question.geminiQuestion!;
    }
    generateQuestion += "Please summarize the answer";
    return generateQuestion;
  }
}
