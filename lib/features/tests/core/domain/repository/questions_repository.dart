import 'package:dri_learn/features/tests/core/domain/model/question_model.dart';
import 'package:dri_learn/features/tests/core/domain/model/question_type_model.dart';

abstract class QuestionsRepository {
  Future<List<QuestionModel>> getQuestions({QuestionType? type});
}
