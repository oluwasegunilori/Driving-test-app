import 'dart:async';

import 'package:dri_learn/features/history/data/model/test_history_entity.dart';
import 'package:dri_learn/features/tests/core/data/converters/string_list_converter.dart';
import 'package:dri_learn/features/tests/core/data/model/question_entity.dart';
import 'package:dri_learn/features/tests/core/data/sources/local/question_dao.dart';
import 'package:dri_learn/features/tests/core/data/sources/local/test_history_dao.dart';
import 'package:dri_learn/features/tests/core/domain/model/question_type_model.dart';
import 'package:dri_learn/features/tests/core/domain/model/test_type.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


part 'app_database.g.dart';

@Database(version: 1, entities: [QuestionEntity, TestHistoryEntity])
abstract class AppDatabase extends FloorDatabase {
  QuestionDao get questionDao;
  TestHistoryDao get testHistoryDao;
}
