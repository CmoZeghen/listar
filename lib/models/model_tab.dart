import 'package:flutter/material.dart';

class TabModel {
  final GlobalKey keyContentItem;
  final GlobalKey keyTabItem;
  final String title;

  TabModel({
    required this.keyContentItem,
    required this.keyTabItem,
    required this.title,
  });

  factory TabModel.fromJson(Map<String, dynamic> json) {
    return TabModel(
      keyContentItem: GlobalKey(),
      keyTabItem: GlobalKey(),
      title: json['title'] ?? 'Unknown',
    );
  }
}
