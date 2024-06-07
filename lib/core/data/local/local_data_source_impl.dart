import 'dart:convert';

import 'package:dri_learn/core/data/local/local_data_source.dart';
import 'package:dri_learn/features/authentication/domain/model/user_entity.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class LocalDataSourceImpl extends LocalDataSource {
  String userKey = "USER:DATA";
  final StreamingSharedPreferences pfDb;

  LocalDataSourceImpl(this.pfDb);
  @override
  Stream<User?> currentUser() {
    return pfDb.getString(userKey, defaultValue: "").map((data) {
      if (data.isEmpty) {
        return null;
      } else {
        return User.fromJson(json.decode(data));
      }
    });
  }

  @override
  Future<void> setCurrentUser(User user) async {
    await pfDb.setString(userKey, json.encode(user.toJson()));
  }
}
