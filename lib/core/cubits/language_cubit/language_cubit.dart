import 'package:cubic_task/core/local_storage/shared_preference.dart';
import 'package:cubic_task/core/utils/constants/shared_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'language_states.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitialLangState());
  Locale? appLocal;

  static LanguageCubit get(context) => BlocProvider.of(context);
  String currentLang = "ar";

  /// CHANGE LANGUAGE
  Future<void> changeLang(newLang, context) async {
    currentLang = newLang;
    SharedText.currentLanguage = currentLang;
    SharedPreference.setLanguage(newLang);
    appLocal = Locale(newLang);
    await AppLocalizations.delegate.load(appLocal!);
    emit(UpdateNewLangState(appLocal!));
  }

  /// GET LANGUAGE
  getLang() async {
    emit(GetLangLangState());
    await SharedPreference.getLanguage().then((lang) {
      if (lang == null) {
        SharedPreference.setLanguage(currentLang);
      } else {
        currentLang = lang;
      }
    });
    appLocal = Locale(currentLang);
    SharedText.currentLanguage = currentLang;
    AppLocalizations.delegate.load(appLocal!);
    currentLang = appLocal.toString();
    emit(UpdateLangState(appLocal!));
  }
}
