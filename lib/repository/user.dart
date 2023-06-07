import 'dart:convert';

import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';

class UserRepository {
  ///Fetch api login
  static Future<UserModel?> login({
    required String username,
    required String password,
  }) async {
    final Map<String, dynamic> params = {
      "username": username,
      "password": password,
    };
    final response = await Api.login(params);

    if (response.success) {
      return UserModel.fromJson(response.data);
    }
  }

  ///Fetch api validToken
  static Future<bool> validateToken() async {
    final response = await Api.validateToken();
    if (response.success) {
      return true;
    }
    return false;
  }

  ///Save User
  static Future<bool> saveUser({required UserModel user}) async {
    return await Preferences.setString(
      Preferences.user,
      jsonEncode(user.toJson()),
    );
  }

  ///Load User
  static Future<UserModel?> loadUser() async {
    final result = Preferences.getString(Preferences.user);
    if (result != null) {
      return UserModel.fromJson(jsonDecode(result));
    }
  }

  ///Delete User
  static Future<bool> deleteUser() async {
    return await Preferences.remove(Preferences.user);
  }
}
