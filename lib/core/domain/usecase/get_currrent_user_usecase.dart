import 'package:ontario_g1_test_2024/core/domain/repository/user_repository.dart';

import '../../../features/authentication/domain/model/user_entity.dart';

class GetCurrentUserUseCase {
  final UserRepository _userRepository;

  GetCurrentUserUseCase(this._userRepository);

  Stream<User?> call() {
    return _userRepository.currentUser();
  }
}
