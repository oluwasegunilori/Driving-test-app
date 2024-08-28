import 'package:ontario_g1_test_2024/features/history/data/model/test_history_entity.dart';
import 'package:ontario_g1_test_2024/features/tests/core/domain/model/test_type.dart';
import 'package:floor/floor.dart';

@dao
abstract class TestHistoryDao {
  @insert
  Future<void> insertData(TestHistoryEntity entity);

  @Query('SELECT * FROM $testHistoryTable')
  Future<List<TestHistoryEntity>> findAllTests();

  @Query('SELECT * FROM $testHistoryTable WHERE testType = :testType')
  Future<List<TestHistoryEntity>> getAllUniqueTest(TestType testType);
}
