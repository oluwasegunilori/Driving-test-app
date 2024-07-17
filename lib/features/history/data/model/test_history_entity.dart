import 'package:dri_learn/features/history/domain/model/test_history_model.dart';
import 'package:dri_learn/features/tests/core/data/converters/string_list_converter.dart';
import 'package:dri_learn/features/tests/core/domain/model/test_type.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

const String testHistoryTable = "test_history_table";

@Entity(tableName: testHistoryTable)
class TestHistoryEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  int? id;
  @ColumnInfo(name: "missed_question_ids")
  @TypeConverters([StringListConverter])
  final List<String> missedQuestionIds;
  @ColumnInfo(name: "score_rate")
  final double scoreRate;
  @ColumnInfo(name: "no_of_questions")
  final int numberOfQuestions;
  @ColumnInfo(name: "no_of_correct_answers")
  final int noOfCorrectAnswers;
  @ColumnInfo(name: "test_type")
  @TypeConverters([TestTypeConverter])
  final TestType testType;
  final int date;

  TestHistoryEntity(
      {required this.missedQuestionIds,
      required this.scoreRate,
      required this.numberOfQuestions,
      required this.noOfCorrectAnswers,
      required this.testType,
      required this.date});

  @override
  List<Object?> get props => [
        id,
        missedQuestionIds,
        scoreRate,
        numberOfQuestions,
        noOfCorrectAnswers,
        testType,
        date
      ];

  DateTime get eventDate => DateTime.fromMillisecondsSinceEpoch(date);

  TestHistoryModel toDomain() {
    return TestHistoryModel(
        id: id.toString(),
        missedQuestionIds: missedQuestionIds,
        scoreRate: scoreRate,
        numberOfQuestions: numberOfQuestions,
        noOfCorrectAnswers: noOfCorrectAnswers,
        testType: testType,
        date: eventDate);
  }
}
