import 'package:listar_flutter/models/model.dart';

class HomePageModel {
  final List<ImageModel> banner;
  final List<CategoryModel> category;
  final List<ProductModel> popular;
  final List<ProductModel> list;

  HomePageModel({
    required this.banner,
    required this.category,
    required this.popular,
    required this.list,
  });

  factory HomePageModel.fromJson(Map<String, dynamic> json) {
    return HomePageModel(
      banner: List.from(json['banner'] ?? []).map((item) {
        return ImageModel.fromJson(item);
      }).toList(),
      category: List.from(json['category'] ?? []).map((item) {
        return CategoryModel.fromJson(item);
      }).toList(),
      popular: List.from(json['popular'] ?? []).map((item) {
        return ProductModel.fromJson(item);
      }).toList(),
      list: List.from(json['list'] ?? []).map((item) {
        return ProductModel.fromJson(item);
      }).toList(),
    );
  }
}
