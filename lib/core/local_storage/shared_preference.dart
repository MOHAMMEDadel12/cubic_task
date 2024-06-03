import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cubic_task/core/local_storage/local_keys.dart';

class SharedPreference {
  static SharedPreferences? _securedStorage;

  static Future getInstance() async {
    _securedStorage ??= await SharedPreferences.getInstance();
    debugPrint("shared preferences is created");
    return _securedStorage;
  }

  /// Setters
  /// Set Language
  static Future<bool> setLanguage(String language) async {
    return await _securedStorage!.setString(LocalKeys.language, language);
  }

  /// Set Access Token
  static Future<bool> setUserToken(String token) async {
    return await _securedStorage!.setString(LocalKeys.userToken, token);
  }

  /// Set Active Workspace ID
  static Future<bool> setActiveWorkspaceID(String id) async {
    return await _securedStorage!.setString(LocalKeys.workspaceID, id);
  }


  /// Set List Of Workspaces
  static Future<bool> setListOfWorkspaces(List<String> workspacesList) async {
    return await _securedStorage!.setStringList(LocalKeys.workspacesList, workspacesList);
  }

  /// Set User Map
  static Future<bool> setUserMap(String userMap) async {
    return await _securedStorage!.setString(LocalKeys.userMap, userMap);
  }

  /// Set Is Light
  static Future<bool> setIsLight(bool isLight) async {
    return await _securedStorage!.setBool(LocalKeys.isLight, isLight);
  }

  /// Getters
  /// Get Language
  static Future<String?> getLanguage() async {
    return _securedStorage!.getString(LocalKeys.language);
  }

  /// Get Access Token
  static Future<String?> getUserToken() async {
    return _securedStorage!.getString(LocalKeys.userToken);
  }


  /// Get Active Workspace ID
  static Future<String?> getActiveWorkspaceID() async {
    return _securedStorage!.getString(LocalKeys.workspaceID);
  }

  /// Get Active Workspace ID
  static Future<List<String>?> getWorkspacesList() async {
    return _securedStorage!.getStringList(LocalKeys.workspacesList);
  }

  /// Get User Map
  static Future<String?> getUserMap() async {
    return _securedStorage!.getString(LocalKeys.userMap);
  }

  /// Get Is Light
  static Future<bool?> getIsLight() async {
    return _securedStorage!.getBool(LocalKeys.isLight);
  }

  /// Clear Local
  static clearLocalStorage() {
    _securedStorage!.clear();
  }
}
