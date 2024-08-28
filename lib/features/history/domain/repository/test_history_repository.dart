import 'package:ontario_g1_test_2024/features/history/domain/model/test_history_model.dart';

abstract class TestHistoryRepository {
  Future<void> saveTest(TestHistoryModel testHistory);
  Future<List<TestHistoryModel>> getTestHistory();
}
