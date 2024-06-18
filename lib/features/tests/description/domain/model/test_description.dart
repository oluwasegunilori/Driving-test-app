import 'package:dri_learn/features/testOptions/domain/model/test_type.dart';
import 'package:equatable/equatable.dart';

class TestDescription extends Equatable {
  final String id;
  final String description;
  final TestType testType;

  const TestDescription(
      {required this.id, required this.description, required this.testType});

  @override
  List<Object> get props => [id, description, testType];
}
