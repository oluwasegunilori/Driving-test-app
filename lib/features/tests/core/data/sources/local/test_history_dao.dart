import 'package:dri_learn/features/history/data/model/test_history_entity.dart';
import 'package:floor/floor.dart';


@dao
abstract class TestHistoryDao {

  @insert
  Future<void> insertData(TestHistoryEntity entity);

  @Query('SELECT * FROM $testHistoryTable')
  Future<List<TestHistoryEntity>> findAllTests();

}