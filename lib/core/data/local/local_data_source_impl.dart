import 'dart:convert';

import 'package:dri_learn/core/data/local/local_data_source.dart';
import 'package:dri_learn/features/authentication/domain/model/user_entity.dart';
import 'package:dri_learn/features/history/domain/model/test_history_model.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class LocalDataSourceImpl extends LocalDataSource {
  String userKey = "USER:DATA";
  final StreamingSharedPreferences _pfDb;

  LocalDataSourceImpl(this._pfDb);
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
      
  }
}
