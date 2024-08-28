import 'package:ontario_g1_test_2024/features/history/data/model/test_history_entity.dart';
import 'package:ontario_g1_test_2024/features/tests/core/domain/model/test_type.dart';
import 'package:equatable/equatable.dart';

class TestHistoryModel extends Equatable {
  final String id;
  final List<String> missedQuestionIds;
  final double scoreRate;
  final int numberOfQuestions;
  final int noOfCorrectAnswers;
  final TestType testType;
  final DateTime date;

  const TestHistoryModel(
      {required this.id,
      required this.missedQuestionIds,
      required this.scoreRate,
      required this.numberOfQuestions,
      required this.noOfCorrectAnswers,
      required this.testType,
      required this.date});

  @override
  List<Object> get props => [
        id,
        missedQuestionIds,
        scoreRate,
        numberOfQuestions,
        noOfCorrectAnswers,
        testType,
        date
      ];

  TestHistoryEntity toEntity() {
    return TestHistoryEntity(
        missedQuestionIds: missedQuestionIds,
        scoreRate: scoreRate,
        numberOfQuestions: numberOfQuestions,
        noOfCorrectAnswers: noOfCorrectAnswers,
        testType: testType,
        date: date.millisecondsSinceEpoch);
  }
}
