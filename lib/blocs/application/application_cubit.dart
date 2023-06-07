import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(ApplicationState.loading);

  ///On Setup Application
  void onSetup() async {
    ///Notify loading
    emit(ApplicationState.loading);

    ///Firebase init
    await Firebase.initializeApp();

    ///Setup SharedPreferences
    await Preferences.setPreferences();

    ///Get old Theme & Font & Language
    final oldTheme = Preferences.getString(Preferences.theme);
    final oldFont = Preferences.getString(Preferences.font);
    final oldLanguage = Preferences.getString(Preferences.language);
    final oldDarkOption = Preferences.getString(Preferences.darkOption);
    final oldBusiness = Preferences.getString(Preferences.business);

    DarkOption? darkOption;
    String? font;
    ThemeModel? theme;

    ///Setup Language
    if (oldLanguage != null) {
      AppBloc.languageCubit.onUpdate(Locale(oldLanguage));
    }

    ///Find font support available [Dart null safety issue]
    try {
      font = AppTheme.fontSupport.firstWhere((item) {
        return item == oldFont;
      });
    } catch (e) {
      UtilLogger.log("ERROR", e);
    }

    if (oldTheme != null) {
      try {
        theme = ThemeModel.fromJson(jsonDecode(oldTheme));
      } catch (e) {
        UtilLogger.log("ERROR", e);
      }
    }

    ///check old dark option
    if (oldDarkOption != null) {
      switch (oldDarkOption) {
        case 'off':
          darkOption = DarkOption.alwaysOff;
          break;
        case 'on':
          darkOption = DarkOption.alwaysOn;
          break;
        default:
          darkOption = DarkOption.dynamic;
      }
    }

    ///Setup Theme & Font with dark Option
    AppBloc.themeCubit.onChangeTheme(
      theme: theme,
      font: font,
      darkOption: darkOption,
    );

    ///Setup Your Business
    switch (oldBusiness) {
      case 'realEstate':
        await AppBloc.businessCubit.onChangeBusiness(
          BusinessState.realEstate,
        );
        break;
      case 'event':
        await AppBloc.businessCubit.onChangeBusiness(
          BusinessState.event,
        );
        break;
      case 'food':
        await AppBloc.businessCubit.onChangeBusiness(
          BusinessState.food,
        );
        break;
      default:
        await AppBloc.businessCubit.onChangeBusiness(BusinessState.basic);
    }

    ///Authentication begin check
    await AppBloc.authenticateCubit.onCheck();

    ///First or After upgrade version show intro preview app
    final hasReview = Preferences.containsKey(
      '${Preferences.reviewIntro}.${Application.version}',
    );
    if (hasReview) {
      ///Notify
      emit(ApplicationState.completed);
    } else {
      ///Notify
      emit(ApplicationState.intro);
    }
  }

  ///On Complete Intro
  void onCompletedIntro() async {
    await Preferences.setBool(
      '${Preferences.reviewIntro}.${Application.version}',
      true,
    );

    ///Notify
    emit(ApplicationState.completed);
  }
}
