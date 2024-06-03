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
  Future<Either<CustomError, UserModel>> login({
    required String email,
    required String password,
  });

  Future<Either<CustomError, SuccessModel>> forgetPassword({
    required String email,
  });

  Future<Either<CustomError, UserModel>> registerUser({
    required String name,
    required String email,
    required String password,
  });

  /// Check link of Reset Password if expired or not
  Future<Either<CustomError, SuccessModel>> resetPassword({
    required String hashCode,
    required String password,
    required String confirmPassword,
  });
}

class AuthenticationRemoteDataSourceImplementation
    implements AuthenticationRemoteDataSource {
  final AuthenticationLocalDataSource authenticationLocalDataSource;
  final SharedLocalDataSource sharedLocalDataSource;

  AuthenticationRemoteDataSourceImplementation({
    required this.authenticationLocalDataSource,
    required this.sharedLocalDataSource,
  });

  /// Login
  @override
  Future<Either<CustomError, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await DioHelper.postData(
          url: "${EndPointKeys.login}?email=$email&password=$password");

      UserModel user = UserModel.fromJson(response.data['data']['user']);

      /// Adding Token To Header
      DioHelper.dio.options.headers.addAll(
          {"Authorization": "Bearer ${response.data['data']['access_token']}"});

      /// Set User Token In Shared Text
      SharedText.userToken = response.data['data']['access_token'];

      /// Save Token In Local Storage
      await authenticationLocalDataSource.saveTokenInLocalStorage(
        userToken: response.data['data']['access_token'],
      );

      /// Save Active Workspace ID In Local Storage
      // if (response.data['data']['active_workspace_id'] != null) {
      //   await sharedLocalDataSource.saveActiveWorkspaceIDInLocalStorage(
      //     activeWorkspaceID:
      //         response.data['data']['active_workspace_id'].toString(),
      //   );
      // }

      // /// Save List Of Workspaces In Local Storage
      // if (response.data['data']['workspaces'] != []) {
      //   await sharedLocalDataSource.saveWorkspaceListInLocalStorage(
      //     workspacesList:
      //         workspacesListFromJson(response.data['data']['workspaces']),
      //   );
      // }

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

      if (SharedText.hashCodeText.isNotEmpty) {
        collectData.addAll({'hash': SharedText.hashCodeText});
      }

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

      /// Save Active Workspace ID In Local Storage
      if (response.data['data']['active_workspace_id'] != null) {
        await sharedLocalDataSource.saveActiveWorkspaceIDInLocalStorage(
          activeWorkspaceID:
              response.data['data']['active_workspace_id'].toString(),
        );
      }

      // /// Save List Of Workspaces In Local Storage
      // if (response.data['data']['workspaces'] != []) {
      //   await sharedLocalDataSource.saveWorkspaceListInLocalStorage(
      //     workspacesList:
      //         workspacesListFromJson(response.data['data']['workspaces']),
      //   );
      // }

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

  @override
  Future<Either<CustomError, SuccessModel>> forgetPassword(
      {required String email}) async {
    try {
      Response response = await DioHelper.postData(
          url: EndPointKeys.forgetPassword,
          queryParameters: {
            "email": email,
          });
      SuccessModel successModel = SuccessModel.fromJson(response.data);
      return Right(successModel);
    } on CustomException catch (error) {
      return Left(
        CustomError(
          errorMessage: error.errorMessage,
          statusCode: error.statusCode,
        ),
      );
    }
  }

  @override
  Future<Either<CustomError, SuccessModel>> resetPassword({
    required String hashCode,
    required String password,
    required String confirmPassword,
  //  required String encryptUserId,
  }) async {
    try {
      Response response = await DioHelper.postData(
          url: "${EndPointKeys.resetPassword}/$hashCode",
          data: {
            "password": password,
            "confirm_password": confirmPassword,
          });

      SuccessModel successModel = SuccessModel.fromJson(response.data);
      return Right(successModel);
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
