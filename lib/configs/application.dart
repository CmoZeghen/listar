import 'package:flutter/material.dart';

class Application {
  static const bool debug = true;
  static const String version = '1.1.0';
  static const String domain = 'http://dev.listarapp.com/index.php/wp-json';
  static const String googleAPI = 'AIzaSyAGHlk0PoZ-BdSwUJh_HGSHXWKlARE4Pt8';
  static final Map<String, GlobalKey> globalKey = {
    'submit': GlobalKey(),
    'business': GlobalKey(),
  };

  ///Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
