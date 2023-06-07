import 'package:flutter/material.dart';
import 'package:listar_flutter/models/model.dart';

class ListSetting {
  static List<CategoryModel> category = [];
  static List<CategoryModel> features = [];
  static List<CategoryModel> locations = [];
  static List<SortModel> sort = [];
  static int perPage = 20;
  static ProductViewType modeView = ProductViewType.list;
  static double minPrice = 0.0;
  static double maxPrice = 100.0;
  static List<String> color = [];
  static String unit = 'USD';
  static TimeOfDay startHour = const TimeOfDay(hour: 8, minute: 0);
  static TimeOfDay endHour = const TimeOfDay(hour: 15, minute: 0);
  static List<SortModel> listSortDefault = [
    {
      "code": "lasted",
      "title": "lasted_post",
      "icon": Icons.sort_outlined,
    },
    {
      "code": "oldest",
      "title": "oldest_post",
      "icon": Icons.swap_vert,
    },
    {
      "code": "most_view",
      "title": "most_view",
      "icon": Icons.visibility_outlined,
    },
    {
      "code": "rating",
      "title": "review_rating",
      "icon": Icons.trending_up_outlined,
    },
  ].map((item) => SortModel.fromJson(item)).toList();

  ///Singleton factory
  static final ListSetting _instance = ListSetting._internal();

  factory ListSetting() {
    return _instance;
  }

  ListSetting._internal();
}
