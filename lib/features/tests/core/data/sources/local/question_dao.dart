
import 'package:dri_learn/features/tests/core/data/model/question_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class QuestionDao {

  @insert
  Future<void> insertQuestion(QuestionEntity question);

  @Query('SELECT * FROM $questionTable')
  Future<List<QuestionEntity>> findAllQuestions();

}