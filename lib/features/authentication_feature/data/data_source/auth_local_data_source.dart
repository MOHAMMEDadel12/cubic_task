import 'dart:convert';
import 'package:cubic_task/core/local_storage/shared_preference.dart';
import 'package:cubic_task/features/authentication_feature/data/models/user_model.dart';

abstract class AuthenticationLocalDataSource {
  /// Save User Token In Local Storage
  Future<bool> saveTokenInLocalStorage({required String userToken});

  /// Save User Model In Local Storage
  Future<bool> saveUserModelInLocalStorage({required UserModel userMap});
}

class AuthenticationLocalDataSourceImplementation
    implements AuthenticationLocalDataSource {
  /// Save User Token In Local Storage
  @override
  Future<bool> saveTokenInLocalStorage({required String userToken}) async {
    return await SharedPreference.setUserToken(userToken);
  }

  /// Save User Model In Local Storage
  @override
  Future<bool> saveUserModelInLocalStorage({required UserModel userMap}) async {
    return await SharedPreference.setUserMap(json.encode(userMap));
  }
}
