import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class UtilOther {
  static fieldFocusChange(
    BuildContext context,
    FocusNode current,
    FocusNode next,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static hiddenKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<String?> getDeviceToken() async {
    await FirebaseMessaging.instance.requestPermission();
    return await FirebaseMessaging.instance.getToken();
  }

  ///Singleton factory
  static final UtilOther _instance = UtilOther._internal();

  factory UtilOther() {
    return _instance;
  }

  UtilOther._internal();
}
