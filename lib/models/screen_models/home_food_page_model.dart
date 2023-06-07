import 'package:listar_flutter/models/model.dart';

class HomeFoodPageModel {
  final List<CountryModel> country;
  final List<ProductFoodModel> banners;
  final List<CategoryModel> category;
  final List<ProductFoodModel> recommends;
  final List<ProductFoodModel> locations;
  final CategoryModel promotion;

  HomeFoodPageModel({
    required this.country,
    required this.banners,
    required this.category,
    required this.recommends,
    required this.locations,
    required this.promotion,
  });

  factory HomeFoodPageModel.fromJson(Map<String, dynamic> json) {
    return HomeFoodPageModel(
      country: (json['country'] as List).map((e) {
        return CountryModel.fromJson(e);
      }).toList(),
      banners: (json['banners'] as List).map((e) {
        return ProductFoodModel.fromJson(e);
      }).toList(),
      category: (json['category'] as List).map((e) {
        return CategoryModel.fromJson(e);
      }).toList(),
      recommends: (json['banners'] as List).map((e) {
        return ProductFoodModel.fromJson(e);
      }).toList(),
      locations: (json['banners'] as List).map((e) {
        return ProductFoodModel.fromJson(e);
      }).toList(),
      promotion: CategoryModel.fromJson(json['promotion']),
    );
  }
}
