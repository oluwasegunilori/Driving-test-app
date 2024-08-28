import 'dart:convert';

import 'package:ontario_g1_test_2024/core/data/local/local_data_source.dart';
import 'package:ontario_g1_test_2024/features/authentication/domain/model/user_entity.dart';
import 'package:ontario_g1_test_2024/features/history/domain/model/test_history_model.dart';
import 'package:ontario_g1_test_2024/features/tests/core/data/sources/local/test_history_dao.dart';
import 'package:ontario_g1_test_2024/features/tests/core/domain/model/test_type.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class LocalDataSourceImpl extends LocalDataSource {
  String userKey = "USER:DATA";
  final StreamingSharedPreferences _pfDb;
  final TestHistoryDao _testHistoryDao;

  LocalDataSourceImpl(this._pfDb, this._testHistoryDao);
  @override
  Stream<User?> currentUser() {
    return _pfDb.getString(userKey, defaultValue: "").map((data) {
      if (data.isEmpty) {
        return null;
      } else {
        return User.fromJson(json.decode(data));
      }
    });
  }

  @override
  Future<void> setCurrentUser(User user) async {
    _pfDb.setString(userKey, json.encode(user.toJson()));
  }

  @override
  Future<void> saveTestScore(TestHistoryModel testHistory) async {
    print(testHistory);
    _testHistoryDao.insertData(testHistory.toEntity());
  }

  @override
  Future<List<TestHistoryModel>> getUniqueTests(TestType testType) async {
    var result = await _testHistoryDao.getAllUniqueTest(testType);
    return result.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<TestHistoryModel>> getTests() async {
    var result = await _testHistoryDao.findAllTests();
    return result.map((e) => e.toDomain()).toList();
  }
}
