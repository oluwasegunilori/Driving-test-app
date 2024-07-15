// ignore: constant_identifier_names
enum QuestionType {
  Sign("Sign"),
  Knowledge("Knowledge");

  final String value;

  const QuestionType(this.value);

  static QuestionType fromString(String value) {
    return QuestionType.values.firstWhere(
      (enumValue) => enumValue.value == value,
      orElse: () => throw ArgumentError('Invalid enum value: $value'),
    );
  }

  String toJson() => value;
}
