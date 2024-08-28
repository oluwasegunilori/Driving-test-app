import 'package:ontario_g1_test_2024/core/data/local/local_data_source.dart';
import 'package:ontario_g1_test_2024/features/history/domain/model/test_history_model.dart';
import 'package:ontario_g1_test_2024/features/history/domain/repository/test_history_repository.dart';

class TestHistoryRepositoryImpl extends TestHistoryRepository {
  final LocalDataSource _localDataSource;

  TestHistoryRepositoryImpl(this._localDataSource);

  @override
  Future<void> saveTest(TestHistoryModel testHistory) async {
    _localDataSource.saveTestScore(testHistory);
  }

  @override
  Future<List<TestHistoryModel>> getTestHistory() {
    return _localDataSource.getTests();
  }
}
