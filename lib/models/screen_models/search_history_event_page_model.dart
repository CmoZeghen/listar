import 'package:listar_flutter/models/model.dart';

class SearchHistoryEventPageModel {
  final List<CategoryModel> discover;
  final List<ProductEventModel> recently;
  final List<ProductEventModel> history;

  SearchHistoryEventPageModel({
    required this.discover,
    required this.recently,
    required this.history,
  });

  factory SearchHistoryEventPageModel.fromJson(Map<String, dynamic> json) {
    final Iterable refactorDiscover = json['discover'] ?? [];
    final Iterable refactorRecently = json['recently'] ?? [];
    final Iterable refactorHistory = json['history'] ?? [];

    final listDiscover = refactorDiscover.map((item) {
      return CategoryModel.fromJson(item);
    }).toList();

    final listRecently = refactorRecently.map((item) {
      return ProductEventModel.fromJson(item);
    }).toList();

    final listHistory = refactorHistory.map((item) {
      return ProductEventModel.fromJson(item);
    }).toList();

    return SearchHistoryEventPageModel(
      discover: listDiscover,
      recently: listRecently,
      history: listHistory,
    );
  }
}
