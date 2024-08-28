import 'package:ontario_g1_test_2024/features/tests/core/domain/model/question_model.dart';
import 'package:ontario_g1_test_2024/features/tests/core/domain/model/test_type.dart';

abstract class QuestionsRepository {
  Future<List<QuestionModel>> getQuestions({TestType? type});
}
