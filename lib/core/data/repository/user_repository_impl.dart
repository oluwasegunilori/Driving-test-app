import 'package:ontario_g1_test_2024/core/data/local/local_data_source.dart';
import 'package:ontario_g1_test_2024/core/domain/repository/user_repository.dart';

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
