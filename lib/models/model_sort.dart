import 'package:flutter/material.dart';

class SortModel {
  final String code;
  final String title;
  final IconData icon;

  SortModel(
    this.code,
    this.title,
    this.icon,
  );

  factory SortModel.fromJson(Map<String, dynamic> json) {
    return SortModel(
      json['code'] ?? "Unknown",
      json['title'] ?? "Unknown",
      json['icon'] ?? Icons.help,
    );
  }
}
