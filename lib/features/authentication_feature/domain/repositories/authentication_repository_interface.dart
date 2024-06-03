import 'package:dartz/dartz.dart';
import 'package:cubic_task/core/models/success_model.dart';
import 'package:cubic_task/core/network/errors/custom_error.dart';

abstract class AuthenticationRepositoryInterface {
  /// Login Method
  Future<Either<CustomError, SuccessModel>> login({
    required String email,
    required String password,
  });

  Future<Either<CustomError, SuccessModel>> registerUser({
    required String name,
    required String email,
    required String password,
  });


  Future<Either<CustomError, SuccessModel>> forgetPassword({
    required String email,
  });

  /// Check link of Reset Password if expired or not
  Future<Either<CustomError, SuccessModel>> resetPassword({
    required String hashCode,
    required String password,
    required String confirmPassword,
  });
}


