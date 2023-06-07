import 'package:listar_flutter/models/model.dart';

class HomeEventPageModel {
  final List<CategoryModel> categorys;
  final List<ProductEventModel> features;
  final List<ProductEventModel> news;

  HomeEventPageModel({
    required this.categorys,
    required this.features,
    required this.news,
  });

  factory HomeEventPageModel.fromJson(Map<String, dynamic> json) {
    return HomeEventPageModel(
      categorys: (json['category'] as List).map((e) {
        return CategoryModel.fromJson(e);
      }).toList(),
      features: (json['feature'] as List).map((e) {
        return ProductEventModel.fromJson(e);
      }).toList(),
      news: (json['new'] as List).map((e) {
        return ProductEventModel.fromJson(e);
      }).toList(),
    );
  }
}
