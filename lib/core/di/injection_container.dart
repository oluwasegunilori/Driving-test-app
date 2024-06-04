import 'package:dri_learn/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:dri_learn/features/authentication/domain/auth_repository.dart';
import 'package:dri_learn/features/authentication/presentation/authentication_bloc.dart';
import 'package:dri_learn/features/onboarding/presentation/onboarding_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //repositories
  sl.registerFactory<AuthRepository>(() => AuthRepositoryImpl());

  //blocs
  sl.registerSingleton<AuthBloc>((AuthBloc(sl.call())));
  sl.registerFactory<OnboardingBloc>(() => OnboardingBloc());
}
