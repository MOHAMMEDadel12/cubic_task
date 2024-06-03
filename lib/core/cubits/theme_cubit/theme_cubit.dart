import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubic_task/core/cubits/theme_cubit/theme_states.dart';
import 'package:cubic_task/core/local_storage/shared_preference.dart';
import 'package:cubic_task/core/utils/constants/shared_text.dart';

class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(InitialThemeState());

  /// Get Object From Theme Cubit
  static ThemeCubit get(context) => BlocProvider.of(context);
  bool isLight = true;

  /// Get Theme
  Future<void> getTheme() async {
    emit(LoadingThemeState());

    /// Check if language saved in shared preference or not
    SharedPreference.getIsLight().then((value) {
      if (value == null) {
        SharedPreference.setIsLight(
          isLight,
        );
      } else {
        isLight = value;
      }
    });
    SharedText.isLight = isLight;
    debugPrint("the app theme is : ${SharedText.isLight}");
    emit(GetThemeSuccessfullyState());
  }

  /// Change Theme
  Future<void> changeTheme({required bool changeIsLight}) async {
    emit(LoadingThemeState());
    isLight = changeIsLight;
    SharedPreference.setIsLight(
      changeIsLight,
    );
    SharedText.isLight = changeIsLight;
    debugPrint("the app theme light is : ${SharedText.isLight}");
    emit(GetThemeSuccessfullyState());
  }
}
