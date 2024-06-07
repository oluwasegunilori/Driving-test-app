import 'package:dri_learn/core/domain/repository/user_repository.dart';

import '../../../features/authentication/domain/model/user_entity.dart';

class GetCurrentUserUseCase {
  final UserRepository _userRepository;

  GetCurrentUserUseCase(this._userRepository);

  Stream<User?> call() {
    return _userRepository.currentUser();
  }
}
