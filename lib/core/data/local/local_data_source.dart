import 'package:dri_learn/features/history/domain/model/test_history_model.dart';
import 'package:dri_learn/features/tests/core/domain/model/test_type.dart';

import '../../../features/authentication/domain/model/user_entity.dart';

abstract class LocalDataSource {
  Stream<User?> currentUser();
  Future<void> setCurrentUser(User user);
  Future<void> saveTestScore(TestHistoryModel testHistory);
  Future<List<TestHistoryModel>> getUniqueTests(TestType testType);
  Future<List<TestHistoryModel>> getTests();
}
