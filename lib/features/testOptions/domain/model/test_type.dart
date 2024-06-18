import 'package:equatable/equatable.dart';

class TestType extends Equatable {
  final String id;
  final String name;
  final String description;

  const TestType(
      {required this.id, required this.name, required this.description});

  @override
  List<Object?> get props => [id, name, description];
}
