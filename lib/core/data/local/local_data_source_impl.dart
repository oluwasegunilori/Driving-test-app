import 'dart:convert';

import 'package:dri_learn/core/data/local/local_data_source.dart';
import 'package:dri_learn/features/authentication/domain/model/user_entity.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

class LocalDataSourceImpl extends LocalDataSource {
  String userKey = "USER:DATA";
  final RxSharedPreferences pfDb;

  LocalDataSourceImpl(this.pfDb);
  @override
  Stream<User?> currentUser() {
    return pfDb.getStringStream(userKey).map((data) {
      if (data == null) {
        return null;
      } else {
        return User.fromJson(json.decode(data));
      }
    });
  }

  @override
  Future<void> setCurrentUser(User user) async {
    pfDb.setString(userKey, json.encode(user.toJson()));
  }
}
