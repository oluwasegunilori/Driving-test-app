import 'dart:math';

import 'package:dri_learn/features/history/domain/model/test_history_model.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../../tests/core/domain/model/test_type.dart';

class TestHistoryItem extends Equatable {
  final String id = const Uuid().v4();
  final int averageScore;
  final TestType testType;
  final String description;
  final List<TestHistoryModel> testHistoryModelList;

  TestHistoryItem(
      {required this.averageScore,
      required this.testType,
      required this.description,
      required this.testHistoryModelList});

  @override
  List<Object?> get props =>
      [id, averageScore, testType, description, testHistoryModelList];

  String? lastThree() {
    if (testHistoryModelList.isEmpty) {
      return null;
    } else {
      var result =
          testHistoryModelList.sublist(max(0, testHistoryModelList.length - 3));
      return result
          .map((e) => "${(e.scoreRate * 100).toInt()}%")
          .toList()
          .join(" - ");
    }
  }
}
