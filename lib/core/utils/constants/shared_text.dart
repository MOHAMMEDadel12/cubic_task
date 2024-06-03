import 'package:flutter/material.dart';
import 'package:cubic_task/core/utils/constants/enums/workspace_member_role_enums.dart';
import 'package:cubic_task/features/authentication_feature/data/models/user_model.dart';
import 'package:cubic_task/features/authentication_feature/domain/entities/user_entity.dart';

class SharedText {
  /// App Configuration
  static const String fontFamily = "Rubik";
  static String currentLanguage = "";
  static late bool isLight;

  /// Users
  static String userToken = "";
  static UserModel userModel = UserModel();
}
