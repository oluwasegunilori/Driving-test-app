import 'package:ontario_g1_test_2024/core/domain/repository/user_repository.dart';
import 'package:ontario_g1_test_2024/features/authentication/domain/model/user_entity.dart';

class SaveUserDataUsecase {
  final UserRepository _userRepository;

  SaveUserDataUsecase(this._userRepository);

  Future<void> call(User user) async {
    _userRepository.setCurrentUser(user);
  }
}
