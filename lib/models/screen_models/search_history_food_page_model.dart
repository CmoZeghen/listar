import 'package:listar_flutter/models/model.dart';

class SearchHistoryFoodPageModel {
  final List<CategoryModel> discover;
  final List<ProductFoodModel> recently;
  final List<ProductFoodModel> history;

  SearchHistoryFoodPageModel({
    required this.discover,
    required this.recently,
    required this.history,
  });

  factory SearchHistoryFoodPageModel.fromJson(Map<String, dynamic> json) {
    final Iterable refactorDiscover = json['discover'] ?? [];
    final Iterable refactorRecently = json['recently'] ?? [];
    final Iterable refactorHistory = json['history'] ?? [];

    final listDiscover = refactorDiscover.map((item) {
      return CategoryModel.fromJson(item);
    }).toList();

    final listRecently = refactorRecently.map((item) {
      return ProductFoodModel.fromJson(item);
    }).toList();

    final listHistory = refactorHistory.map((item) {
      return ProductFoodModel.fromJson(item);
    }).toList();

    return SearchHistoryFoodPageModel(
      discover: listDiscover,
      recently: listRecently,
      history: listHistory,
    );
  }
}
