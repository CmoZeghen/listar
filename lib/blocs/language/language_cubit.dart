import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/utils/utils.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(AppLanguage.defaultLanguage);

  ///On Change Language
  void onUpdate(Locale locale) {
    emit(locale);

    ///Preference save
    Preferences.setString(
      Preferences.language,
      locale.languageCode,
    );
  }
}
