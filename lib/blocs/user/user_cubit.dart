import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/repository/repository.dart';

class UserCubit extends Cubit<UserModel?> {
  UserCubit() : super(null);

  ///Event load user
  Future<UserModel?> onLoadUser() async {
    UserModel? user = await UserRepository.loadUser();
    emit(user);
    return user;
  }

  ///Event fetch user
  Future<UserModel?> onFetchUser() async {
    return await UserRepository.loadUser();
  }

  ///Event save user
  Future<void> onSaveUser(UserModel user) async {
    await UserRepository.saveUser(user: user);
    emit(user);
  }

  ///Event delete user
  void onDeleteUser() {
    FirebaseMessaging.instance.deleteToken();
    UserRepository.deleteUser();
    emit(null);
  }
}
