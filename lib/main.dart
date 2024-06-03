import 'package:cubic_task/app_main.dart';
import 'package:cubic_task/core/local_storage/shared_preference.dart';
import 'package:cubic_task/core/network/dio_helper.dart';
import 'package:cubic_task/core/observer/bloc_observer.dart';
import 'package:cubic_task/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

void main() async {
  /// Initialize Widgets
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize Dio
  DioHelper.init();

  /// Initialize Local Storage
  await SharedPreference.getInstance();

  /// Bloc Observer
  Bloc.observer = MyBlocObserver();

  /// Initialize Get It
  setup();

  /// BLoc Observer
  Bloc.observer = MyBlocObserver();

  runApp(const AppMain());
}
