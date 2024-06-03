import 'package:dartz/dartz.dart';
import 'package:cubic_task/core/models/success_model.dart';
import 'package:cubic_task/core/network/errors/custom_error.dart';
import 'package:cubic_task/features/authentication_feature/domain/repositories/authentication_repository_interface.dart';

class RegisterUseCase {
  final AuthenticationRepositoryInterface authenticationRepositoryInterface;

  RegisterUseCase({
    required this.authenticationRepositoryInterface,
  });

  /// Login Use Case Function
  Future<Either<CustomError, SuccessModel>> call({
    required String name,
    required String email,
    required String password,
  }) {
    return authenticationRepositoryInterface.registerUser(
      email: email,
      password: password,
      name: name,
    );
  }
}
