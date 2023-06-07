import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class AppBloc {
  static final applicationCubit = ApplicationCubit();
  static final authenticateCubit = AuthenticationCubit();
  static final businessCubit = BusinessCubit();
  static final languageCubit = LanguageCubit();
  static final loginCubit = LoginCubit();
  static final messageCubit = MessageCubit();
  static final searchCubit = SearchCubit();
  static final themeCubit = ThemeCubit();
  static final userCubit = UserCubit();

  static final List<BlocProvider> providers = [
    BlocProvider<ApplicationCubit>(
      create: (context) => applicationCubit,
    ),
    BlocProvider<AuthenticationCubit>(
      create: (context) => authenticateCubit,
    ),
    BlocProvider<BusinessCubit>(
      create: (context) => businessCubit,
    ),
    BlocProvider<LanguageCubit>(
      create: (context) => languageCubit,
    ),
    BlocProvider<LoginCubit>(
      create: (context) => loginCubit,
    ),
    BlocProvider<MessageCubit>(
      create: (context) => messageCubit,
    ),
    BlocProvider<SearchCubit>(
      create: (context) => searchCubit,
    ),
    BlocProvider<ThemeCubit>(
      create: (context) => themeCubit,
    ),
    BlocProvider<UserCubit>(
      create: (context) => userCubit,
    ),
  ];

  static void dispose() {
    applicationCubit.close();
    authenticateCubit.close();
    businessCubit.close();
    languageCubit.close();
    loginCubit.close();
    messageCubit.close();
    searchCubit.close();
    themeCubit.close();
    userCubit.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
