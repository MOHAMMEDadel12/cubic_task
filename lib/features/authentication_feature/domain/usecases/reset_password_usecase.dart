import 'package:dartz/dartz.dart';
import 'package:cubic_task/core/models/success_model.dart';
import 'package:cubic_task/core/network/errors/custom_error.dart';
import 'package:cubic_task/features/authentication_feature/domain/repositories/authentication_repository_interface.dart';

class ResetPasswordUseCase {
  final AuthenticationRepositoryInterface authenticationRepositoryInterface;

  ResetPasswordUseCase({
    required this.authenticationRepositoryInterface,
  });

  /// Create space Use Case Function
  Future<Either<CustomError, SuccessModel>> call({
    required String hashCode,
    required String password,
    required String confirmPassword,
  }) {
    return authenticationRepositoryInterface.resetPassword(
        password: password,
        confirmPassword: confirmPassword,
        hashCode: hashCode);
  }
}
