import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';

class ThemeState {
  final ThemeModel theme;
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final String font;
  final DarkOption darkOption;

  ThemeState({
    required this.theme,
    required this.lightTheme,
    required this.darkTheme,
    required this.font,
    required this.darkOption,
  });

  factory ThemeState.fromDefault() {
    return ThemeState(
      theme: AppTheme.defaultTheme,
      lightTheme: AppTheme.getTheme(
        theme: AppTheme.defaultTheme,
        brightness: Brightness.light,
        font: AppTheme.defaultFont,
      ),
      darkTheme: AppTheme.getTheme(
        theme: AppTheme.defaultTheme,
        brightness: Brightness.dark,
        font: AppTheme.defaultFont,
      ),
      font: AppTheme.defaultFont,
      darkOption: AppTheme.darkThemeOption,
    );
  }
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.fromDefault());

  void onChangeTheme({
    ThemeModel? theme,
    String? font,
    DarkOption? darkOption,
  }) async {
    ///Setup Theme with setting darkOption
    final currentState = AppBloc.themeCubit.state;
    theme ??= currentState.theme;
    font ??= currentState.font;
    darkOption ??= currentState.darkOption;

    ThemeState themeState;

    switch (darkOption) {
      case DarkOption.dynamic:
        Preferences.setString(Preferences.darkOption, 'dynamic');
        themeState = ThemeState(
          theme: theme,
          lightTheme: AppTheme.getTheme(
            theme: theme,
            brightness: Brightness.light,
            font: font,
          ),
          darkTheme: AppTheme.getTheme(
            theme: theme,
            brightness: Brightness.dark,
            font: font,
          ),
          font: font,
          darkOption: darkOption,
        );
        break;
      case DarkOption.alwaysOn:
        Preferences.setString(Preferences.darkOption, 'on');
        themeState = ThemeState(
          theme: theme,
          lightTheme: AppTheme.getTheme(
            theme: theme,
            brightness: Brightness.dark,
            font: font,
          ),
          darkTheme: AppTheme.getTheme(
            theme: theme,
            brightness: Brightness.dark,
            font: font,
          ),
          font: font,
          darkOption: darkOption,
        );
        break;
      case DarkOption.alwaysOff:
        Preferences.setString(Preferences.darkOption, 'off');
        themeState = ThemeState(
          theme: theme,
          lightTheme: AppTheme.getTheme(
            theme: theme,
            brightness: Brightness.light,
            font: font,
          ),
          darkTheme: AppTheme.getTheme(
            theme: theme,
            brightness: Brightness.light,
            font: font,
          ),
          font: font,
          darkOption: darkOption,
        );
        break;
    }

    ///Preference save
    Preferences.setString(
      Preferences.theme,
      jsonEncode(themeState.theme.toJson()),
    );

    ///Preference save
    Preferences.setString(Preferences.font, themeState.font);

    ///Notify
    emit(themeState);
  }
}
