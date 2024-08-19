import 'dart:convert';
import 'dart:math';

import 'package:dri_learn/features/tests/core/domain/model/question_model.dart';
import 'package:dri_learn/features/tests/core/domain/model/test_type.dart';
import 'package:dri_learn/features/tests/core/domain/repository/questions_repository.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

const questionLength = 40;
const knowSignLength = 20;
const singleKnowSignLength = 20;

class QuestionsRepositoryImpl extends QuestionsRepository {
  @override
  Future<List<QuestionModel>> getQuestions({TestType? type}) async {
    String response;
    final remoteResponse = await http
        .get(Uri.parse('https://drilearn.web.app/ontario_test_questions.json'));
    if (remoteResponse.statusCode == 200) {
      response = remoteResponse.body;
    } else {
      response = await rootBundle
          .loadString('assets/data/ontario_test_questions.json');
    }
    final List<dynamic> data = await json.decode(response);
    List<QuestionModel> dataList =
        data.map((json) => QuestionModel.fromJson(json)).toList();
    if (type != TestType.MockTest) {
      var result = dataList.where((item) => item.testType == type).toList();
      result.shuffle(Random(DateTime.now().microsecondsSinceEpoch));
      result = result.take(singleKnowSignLength).toList();
      return result;
    } else {
      List<QuestionModel> result = [];
      var knowledgeList = dataList
          .where((item) => item.testType == TestType.Knowledge)
          .take(knowSignLength)
          .toList();
      knowledgeList.shuffle(Random(DateTime.now().microsecondsSinceEpoch));
      var signList = dataList
          .where((item) => item.testType == TestType.Sign)
          .take(knowSignLength)
          .toList();
      signList.shuffle();
      result.addAll(knowledgeList);
      result.addAll(signList);
      return result;
    }
  }
}
