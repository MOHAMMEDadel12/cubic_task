import 'package:cubic_task/core/cubits/Language_Cubit/language_cubit.dart';
import 'package:cubic_task/core/cubits/theme_cubit/theme_cubit.dart';
import 'package:cubic_task/core/local_data_source/shared_local_data_source.dart';
import 'package:cubic_task/features/authentication_feature/data/data_source/auth_local_data_source.dart';
import 'package:cubic_task/features/authentication_feature/data/data_source/auth_remote_data_source.dart';
import 'package:cubic_task/features/authentication_feature/data/repositories/authentication_repository_implementation.dart';
import 'package:cubic_task/features/authentication_feature/domain/repositories/authentication_repository_interface.dart';
import 'package:cubic_task/features/authentication_feature/domain/usecases/get_branches_usecase.dart';
import 'package:cubic_task/features/authentication_feature/domain/usecases/register_usecase.dart';
import 'package:cubic_task/features/authentication_feature/presentation/logic/register_cubit/register_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  ///
  /// Blocs

  getIt.registerFactory(() =>
      RegisterCubit(registerUseCase: getIt(), getBranchesUseCase: getIt()));
  getIt.registerFactory(() => LanguageCubit());
  getIt.registerFactory(() => ThemeCubit());

  ///
  /// UseCases
  ///

  getIt.registerLazySingleton(
      () => RegisterUseCase(authenticationRepositoryInterface: getIt()));

  getIt.registerLazySingleton(
      () => GetBranchesUseCase(authenticationRepositoryInterface: getIt()));

  ///
  /// Repositories
  ///
  getIt.registerLazySingleton<AuthenticationRepositoryInterface>(() =>
      AuthenticationRepositoryImplementation(
          authenticationRemoteDataSource: getIt(),
          authenticationLocalDataSource: getIt()));

  ///
  /// Remote Data Source
  ///
  getIt.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImplementation(
      authenticationLocalDataSource: getIt(),
      sharedLocalDataSource: getIt(),
    ),
  );

  ///
  /// Local Data Source
  ///
  getIt.registerLazySingleton<AuthenticationLocalDataSource>(
    () => AuthenticationLocalDataSourceImplementation(),
  );

  getIt.registerLazySingleton<SharedLocalDataSource>(
    () => SharedLocalDataSourceImplementation(),
  );
}
