import 'package:dri_learn/features/tests/core/data/model/question_entity.dart';
import 'package:dri_learn/features/tests/core/data/sources/local/question_dao.dart';
import 'package:floor/floor.dart';
part 'app_database.g.dart';

@Database(version: 1, entities: [QuestionEntity])
abstract class AppDatabase extends FloorDatabase {
  QuestionDao get questionDao;
}
