import 'package:ontario_g1_test_2024/features/history/domain/model/test_history_item.dart';
import 'package:ontario_g1_test_2024/features/history/domain/model/test_history_model.dart';
import 'package:ontario_g1_test_2024/features/history/domain/repository/test_history_repository.dart';
import 'package:ontario_g1_test_2024/features/tests/core/domain/model/test_type.dart';

class GetTestHistoryUsecase {
  final TestHistoryRepository testHistoryRepository;

  GetTestHistoryUsecase({required this.testHistoryRepository});

  Future<Map<TestType, TestHistoryItem>> call() async {
    List<TestHistoryModel> result =
        await testHistoryRepository.getTestHistory();
    print(result);
    Map<TestType, TestHistoryItem> data = {};
    for (var testType in TestType.values.reversed) {
      var testTypeList = result.where((e) => e.testType == testType).toList();
      double scoreRate = 0.0;
      if (testTypeList.length > 1) {
        scoreRate = testTypeList
                .map((e) => e.scoreRate)
                .reduce((value, element) => value + element) /
            testTypeList.length;
      } else if (testTypeList.length == 1) {
        scoreRate = testTypeList[0].scoreRate / testTypeList.length;
      }
      data[testType] = TestHistoryItem(
          averageScore: (scoreRate * 100).toInt(),
          testType: testType,
          description: "description",
          testHistoryModelList: testTypeList);
    }
    return data;
  }
}
