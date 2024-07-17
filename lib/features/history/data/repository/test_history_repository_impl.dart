import 'package:dri_learn/core/data/local/local_data_source.dart';
import 'package:dri_learn/features/history/domain/model/test_history_model.dart';
import 'package:dri_learn/features/history/domain/repository/test_history_repository.dart';

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
