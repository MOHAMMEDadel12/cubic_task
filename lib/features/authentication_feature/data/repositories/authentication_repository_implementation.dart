import 'package:dartz/dartz.dart';
import 'package:cubic_task/core/models/success_model.dart';
import 'package:cubic_task/core/network/errors/custom_error.dart';
import 'package:cubic_task/core/utils/constants/shared_text.dart';
import 'package:cubic_task/features/authentication_feature/data/data_source/auth_local_data_source.dart';
import 'package:cubic_task/features/authentication_feature/data/data_source/auth_remote_data_source.dart';
import 'package:cubic_task/features/authentication_feature/data/models/user_model.dart';
import 'package:cubic_task/features/authentication_feature/domain/repositories/authentication_repository_interface.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepositoryInterface {
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;
  final AuthenticationLocalDataSource authenticationLocalDataSource;

  AuthenticationRepositoryImplementation({
    required this.authenticationRemoteDataSource,
    required this.authenticationLocalDataSource,
  });

  /// Login
  @override
  Future<Either<CustomError, SuccessModel>> login({
    required String email,
    required String password,
  }) async {
    /// login user in remote data source
    return await authenticationRemoteDataSource
        .login(
          email: email,
          password: password,
        )
        .then(
          (value) => value.fold(
            (error) {
              return Left(error);
            },
            (user) async {
              /// save the user model in cache
              await saveUserInLocalStorage(user);
              return Right(SuccessModel());
            },
          ),
        );
  }

  /// Register
  @override
  Future<Either<CustomError, SuccessModel>> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    return await authenticationRemoteDataSource
        .registerUser(
          email: email,
          name: name,
          password: password,
        )
        .then(
          (value) => value.fold(
            (error) {
              return Left(error);
            },
            (user) async {
              /// save the user model in cache
              await saveUserInLocalStorage(user);
              return Right(SuccessModel());
            },
          ),
        );
  }

  /// Save User In Local Storage
  Future<Either<CustomError, SuccessModel>> saveUserInLocalStorage(
      UserModel user) async {
    try {
      await authenticationLocalDataSource.saveUserModelInLocalStorage(
        userMap: user,
      );
      SharedText.userModel = user;
      return right(SuccessModel());
    } catch (e) {
      return left(
        CustomError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Forget Password
  @override
  Future<Either<CustomError, SuccessModel>> forgetPassword(
      {required String email}) async {
    return await authenticationRemoteDataSource
        .forgetPassword(
          email: email,
        )
        .then(
          (value) => value.fold(
            (error) => Left(CustomError(errorMessage: error.errorMessage)),
            (success) => Right(
              SuccessModel(),
            ),
          ),
        );
  }

  /// Reset Password
  @override
  Future<Either<CustomError, SuccessModel>> resetPassword({
    required String hashCode,
    required String password,
    required String confirmPassword,
  }) async {
    return await authenticationRemoteDataSource
        .resetPassword(
          hashCode: hashCode,
          password: password,
          confirmPassword: confirmPassword,
        )
        .then(
          (value) => value.fold(
            (error) => Left(CustomError(errorMessage: error.errorMessage)),
            (success) => Right(
              SuccessModel(),
            ),
          ),
        );
  }
}
