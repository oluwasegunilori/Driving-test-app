
import 'package:dri_learn/features/history/domain/model/test_history_model.dart';

import '../../../features/authentication/domain/model/user_entity.dart';

abstract class LocalDataSource {
  Stream<User?> currentUser();
  Future<void> setCurrentUser(User user);
  Future<void> saveTestScore(TestHistoryModel testHistory);
}
