import 'package:dartz/dartz.dart';
import 'package:cubic_task/core/models/success_model.dart';
import 'package:cubic_task/core/network/errors/custom_error.dart';

abstract class AuthenticationRepositoryInterface {
  Future<Either<CustomError, SuccessModel>> registerUser({
    required String name,
    required String email,
    required String password,
  });
}
