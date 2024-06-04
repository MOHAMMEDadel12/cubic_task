import 'package:cubic_task/features/authentication_feature/data/models/branch_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:cubic_task/core/local_data_source/shared_local_data_source.dart';
import 'package:cubic_task/core/models/success_model.dart';
import 'package:cubic_task/core/network/dio_helper.dart';
import 'package:cubic_task/core/network/errors/custom_error.dart';
import 'package:cubic_task/core/network/errors/custom_exception.dart';
import 'package:cubic_task/core/rotues/route_keys.dart';
import 'package:cubic_task/core/utils/constants/shared_text.dart';
import 'package:cubic_task/features/authentication_feature/data/data_source/auth_local_data_source.dart';
import 'package:cubic_task/features/authentication_feature/data/models/user_model.dart';
import '../../../../core/network/end_point_keys.dart';

abstract class AuthenticationRemoteDataSource {
  Future<Either<CustomError, UserModel>> registerUser({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<CustomError, List<BranchModel>>> getBranches();
}

class AuthenticationRemoteDataSourceImplementation
    implements AuthenticationRemoteDataSource {
  final AuthenticationLocalDataSource authenticationLocalDataSource;
  final SharedLocalDataSource sharedLocalDataSource;

  AuthenticationRemoteDataSourceImplementation({
    required this.authenticationLocalDataSource,
    required this.sharedLocalDataSource,
  });

  /// Register
  @override
  Future<Either<CustomError, UserModel>> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic> collectData = {
        "name": name,
        "email": email,
        "password": password,
      };

      Response response = await DioHelper.postData(
        url: RouteKeys.register,
        data: collectData,
      );

      UserModel user = UserModel.fromJson(response.data['data']['user']);

      /// Adding Token To Header
      DioHelper.dio.options.headers.addAll(
          {"Authorization": "Bearer ${response.data['data']['token']}"});

      /// Set User Token In Shared Text
      SharedText.userToken = response.data['data']['token'];

      /// Save Token In Local Storage
      await authenticationLocalDataSource.saveTokenInLocalStorage(
        userToken: response.data['data']['token'],
      );

      return Right(user);
    } on CustomException catch (error) {
      return Left(
        CustomError(
          errorMessage: error.errorMessage,
          statusCode: error.statusCode,
        ),
      );
    }
  }

  /// Register
  @override
  Future<Either<CustomError, List<BranchModel>>> getBranches() async {
    try {
      Response response = await DioHelper.getData(
        url: EndPointKeys.getBranches,
      );

      List<BranchModel> branches =
          branchesListFromJson(response.data['result']);

      return Right(branches);
    } on CustomException catch (error) {
      return Left(
        CustomError(
          errorMessage: error.errorMessage,
          statusCode: error.statusCode,
        ),
      );
    }
  }
}
