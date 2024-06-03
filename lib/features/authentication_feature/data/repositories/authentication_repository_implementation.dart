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
              return Right(SuccessModel());
            },
          ),
        );
  }
}
