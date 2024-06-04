import 'package:cubic_task/features/authentication_feature/domain/entities/branch_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:cubic_task/core/models/success_model.dart';
import 'package:cubic_task/core/network/errors/custom_error.dart';
import 'package:cubic_task/features/authentication_feature/domain/repositories/authentication_repository_interface.dart';

class GetBranchesUseCase {
  final AuthenticationRepositoryInterface authenticationRepositoryInterface;

  GetBranchesUseCase({
    required this.authenticationRepositoryInterface,
  });

  /// Login Use Case Function
  Future<Either<CustomError, List<BranchEntity>>> call() {
    return authenticationRepositoryInterface.getBranches();
  }
}
