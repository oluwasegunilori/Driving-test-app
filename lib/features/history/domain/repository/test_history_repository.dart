
import 'package:dri_learn/features/history/domain/model/test_history_model.dart';

abstract class TestHistoryRepository {
  Future<void> saveTest(TestHistoryModel testHistoy);
}
