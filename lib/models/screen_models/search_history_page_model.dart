import 'package:listar_flutter/models/model.dart';

class SearchHistoryPageModel {
  final List<CategoryModel> discover;
  final List<ProductModel> recently;
  final List<ProductModel> history;

  SearchHistoryPageModel({
    required this.discover,
    required this.recently,
    required this.history,
  });

  factory SearchHistoryPageModel.fromJson(Map<String, dynamic> json) {
    final Iterable refactorDiscover = json['discover'] ?? [];
    final Iterable refactorRecently = json['recently'] ?? [];
    final Iterable refactorHistory = json['history'] ?? [];

    final listDiscover = refactorDiscover.map((item) {
      return CategoryModel.fromJson(item);
    }).toList();

    final listRecently = refactorRecently.map((item) {
      return ProductModel.fromJson(item);
    }).toList();

    final listHistory = refactorHistory.map((item) {
      return ProductModel.fromJson(item);
    }).toList();

    return SearchHistoryPageModel(
      discover: listDiscover,
      recently: listRecently,
      history: listHistory,
    );
  }
}
