import 'package:dri_learn/features/tests/core/domain/model/question_model.dart';
import 'package:dri_learn/features/tests/core/domain/model/test_type.dart';

abstract class QuestionsRepository {
  Future<List<QuestionModel>> getQuestions({TestType? type});
}
