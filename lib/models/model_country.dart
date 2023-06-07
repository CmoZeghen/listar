import 'package:listar_flutter/configs/config.dart';

class CountryModel {
  final String code;
  final String title;
  final String image;

  CountryModel({
    required this.code,
    required this.title,
    required this.image,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      code: json['code'] ?? "Unknown",
      title: json['name'] ?? "Unknown",
      image: json['image'] ?? Images.logo,
    );
  }
}
