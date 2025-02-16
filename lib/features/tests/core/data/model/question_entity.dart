import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../domain/model/question_type_model.dart';
import '../converters/string_list_converter.dart';

const questionTable = "question_table";

@Entity(tableName: questionTable)
class QuestionEntity extends Equatable {
  @PrimaryKey()
  final String id;
  final String question;
  @TypeConverters([StringListConverter])
  final List<String> options;
  final String? image;
  final int answer;
  @ColumnInfo(name: "question_type")
  final QuestionType questionType;

  const QuestionEntity(this.id, this.question, this.options, this.image,
      this.answer, this.questionType);

  @override
  List<Object?> get props =>
      [id, question, options, image, answer, questionType];
}
