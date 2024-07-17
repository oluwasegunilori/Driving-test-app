import 'package:dri_learn/features/history/domain/model/test_history_item.dart';
import 'package:dri_learn/features/history/domain/model/test_history_model.dart';
import 'package:dri_learn/features/history/domain/repository/test_history_repository.dart';
import 'package:dri_learn/features/tests/core/domain/model/test_type.dart';

class GetTestHistoryUsecase {
  final TestHistoryRepository testHistoryRepository;

  GetTestHistoryUsecase({required this.testHistoryRepository});

  Future<Map<TestType, TestHistoryItem>> call() async {
    List<TestHistoryModel> result =
        await testHistoryRepository.getTestHistory();
    Map<TestType, TestHistoryItem> data = {};
    for (var testType in TestType.values) {
      var testTypeList = result.where((e) => e.testType == testType).toList();
      double scoreRate = testTypeList
              .map((e) => e.scoreRate)
              .reduce((value, element) => value + element) /
          testTypeList.length;
      data[testType] = TestHistoryItem(
          averageScore: scoreRate.toInt(),
          testType: testType,
          description: "description",
          testHistoryModelList: testTypeList);
    }
    return data;
  }
}
