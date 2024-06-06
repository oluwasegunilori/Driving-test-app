import 'package:dri_learn/core/domain/repository/user_repository.dart';
import 'package:dri_learn/features/authentication/domain/model/user_entity.dart';

class SaveUserDataUsecase {
  final UserRepository _userRepository;

  SaveUserDataUsecase(this._userRepository);

  Future<void> call(User user) async {
    _userRepository.setCurrentUser(user);
  }
}
