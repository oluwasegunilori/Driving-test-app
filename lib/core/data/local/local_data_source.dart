import '../../../features/authentication/domain/model/user_entity.dart';

abstract class LocalDataSource {
  Stream<User?> currentUser();
  Future<void> setCurrentUser(User user);
}
