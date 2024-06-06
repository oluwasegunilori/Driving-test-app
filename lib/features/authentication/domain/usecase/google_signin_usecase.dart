import 'package:dri_learn/core/errors/errors.dart';
import 'package:dri_learn/features/authentication/domain/auth_repository.dart';
import 'package:dri_learn/features/authentication/domain/model/user_entity.dart';
import 'package:either_dart/either.dart';
import 'package:uuid/uuid.dart';

class GoogleSignInUseCase {
  final AuthRepository _authRepository;
  GoogleSignInUseCase(this._authRepository);
  Future<Either<MessageException, User>> call() async {
    try {
      var creds = await _authRepository.googleSignIn();
      return Right(User(
          id: creds.user?.uid ?? const Uuid().v4(),
          name: creds.user?.displayName ?? "",
          email: creds.user?.email ?? ""));
    } on Exception catch (err) {
      return Left(getErrorMessage(err));
    }
  }
}
