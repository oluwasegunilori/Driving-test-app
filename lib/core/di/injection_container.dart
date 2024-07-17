import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dri_learn/core/data/local/app_database.dart';
import 'package:dri_learn/core/data/local/local_data_source.dart';
import 'package:dri_learn/core/data/local/local_data_source_impl.dart';
import 'package:dri_learn/core/data/remote/remote_data_source.dart';
import 'package:dri_learn/core/data/remote/remote_data_source_impl.dart';
import 'package:dri_learn/core/data/repository/user_repository_impl.dart';
import 'package:dri_learn/core/domain/repository/user_repository.dart';
import 'package:dri_learn/core/domain/usecase/get_currrent_user_usecase.dart';
import 'package:dri_learn/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:dri_learn/features/authentication/domain/auth_repository.dart';
import 'package:dri_learn/features/authentication/domain/usecase/google_signin_usecase.dart';
import 'package:dri_learn/features/authentication/domain/usecase/save_user_data_usecase.dart';
import 'package:dri_learn/features/authentication/presentation/authentication_bloc.dart';
import 'package:dri_learn/features/history/data/repository/test_history_repository_impl.dart';
import 'package:dri_learn/features/history/domain/repository/test_history_repository.dart';
import 'package:dri_learn/features/history/domain/usecase/get_test_history_usecase.dart';
import 'package:dri_learn/features/history/domain/usecase/save_test_history_usecase.dart';
import 'package:dri_learn/features/history/presentation/bloc/test_history_bloc.dart';
import 'package:dri_learn/features/onboarding/presentation/onboarding_bloc.dart';
import 'package:dri_learn/features/provinceSelector/data/repository/province_repository_impl.dart';
import 'package:dri_learn/features/provinceSelector/domain/repository/province_repository.dart';
import 'package:dri_learn/features/provinceSelector/presentation/province_bloc.dart';
import 'package:dri_learn/features/tests/core/data/repository/questions_repository_impl.dart';
import 'package:dri_learn/features/tests/core/domain/repository/questions_repository.dart';
import 'package:dri_learn/features/tests/mock/domain/usecase/calculate_mock_test_score.dart';
import 'package:dri_learn/features/tests/mock/presentation/mock_test_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Remote Database
  final fireStoreDb = FirebaseFirestore.instance;
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(db: fireStoreDb));

  //Local database
  final shPf = await StreamingSharedPreferences.instance;
  final floorDb =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(shPf, floorDb.testHistoryDao));

  //repositories
  sl.registerFactory<AuthRepository>(() => AuthRepositoryImpl());
  sl.registerFactory<ProvinceRepository>(
      () => ProvinceRepositoryImpl(remoteDataSource: sl.call()));
  sl.registerFactory<UserRepository>(() => UserRepositoryImpl(sl.call()));
  sl.registerFactory<QuestionsRepository>(() => QuestionsRepositoryImpl());
  sl.registerFactory<TestHistoryRepository>(
      () => TestHistoryRepositoryImpl(sl.call()));

  //usecase
  sl.registerFactory<GoogleSignInUseCase>(() => GoogleSignInUseCase(sl.call()));
  sl.registerFactory<SaveUserDataUsecase>(() => SaveUserDataUsecase(sl.call()));
  sl.registerFactory<GetCurrentUserUseCase>(
      () => GetCurrentUserUseCase(sl.call()));
  sl.registerFactory<CalculateMockTestScore>(() => CalculateMockTestScore());
  sl.registerFactory<SaveTestHistoryUsecase>(
      () => SaveTestHistoryUsecase(repository: sl.call()));
  sl.registerFactory<GetTestHistoryUsecase>(
      () => GetTestHistoryUsecase(testHistoryRepository: sl.call()));

  //blocs
  sl.registerSingleton<AuthBloc>((AuthBloc(sl.call(), sl.call(), sl.call())));
  sl.registerFactory<OnboardingBloc>(() => OnboardingBloc());
  sl.registerFactory<ProvinceBloc>(() => ProvinceBloc(sl.call()));
  sl.registerSingleton<MockTestBloc>((MockTestBloc(
      calculateMockTestScore: sl.call(),
      questionsRepository: sl.call(),
      saveTestHistoryUsecase: sl.call())));
  sl.registerFactory<TestHistoryBloc>(() => TestHistoryBloc(sl.call()));
}
