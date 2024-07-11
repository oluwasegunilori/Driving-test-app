import 'dart:convert';

import 'package:dri_learn/features/tests/core/domain/question_model.dart';
import 'package:dri_learn/features/tests/core/domain/repository/questions_repository.dart';
import 'package:flutter/services.dart' show rootBundle;

class QuestionsRepositoryImpl extends QuestionsRepository {
  @override
  Future<List<QuestionModel>> getQuestions() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    List<QuestionModel> dataList =
        data.map((json) => QuestionModel.fromJson(json)).toList();
    return dataList;
  }
}
