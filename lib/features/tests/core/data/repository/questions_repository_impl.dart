import 'dart:convert';

import 'package:dri_learn/features/tests/core/domain/model/question_model.dart';
import 'package:dri_learn/features/tests/core/domain/model/test_type.dart';
import 'package:dri_learn/features/tests/core/domain/repository/questions_repository.dart';
import 'package:flutter/services.dart' show rootBundle;

const questionLength = 40;
const knowSignLength = 20;

class QuestionsRepositoryImpl extends QuestionsRepository {
  @override
  Future<List<QuestionModel>> getQuestions({TestType? type}) async {
    final String response =
        await rootBundle.loadString('assets/data/test_questions.json');
    final List<dynamic> data = await json.decode(response);
    List<QuestionModel> dataList =
        data.map((json) => QuestionModel.fromJson(json)).toList();
    if (type != null) {
      return dataList
          .where((item) => item.testType == type)
          .take(knowSignLength)
          .toList();
    }
    dataList.shuffle();
    return dataList.take(questionLength).toList();
  }
}
