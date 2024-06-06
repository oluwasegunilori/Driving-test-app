import 'package:dri_learn/core/data/local/local_data_source.dart';
import 'package:dri_learn/core/domain/repository/user_repository.dart';

import '../../../features/authentication/domain/model/user_entity.dart';

class UserRepositoryImpl extends UserRepository {
  final LocalDataSource localDataSource;

  UserRepositoryImpl(this.localDataSource);

  @override
  Stream<User?> currentUser() {
    return localDataSource.currentUser();
  }

  @override
  Future<void> setCurrentUser(User user) async {
    localDataSource.setCurrentUser(user);
  }
}
