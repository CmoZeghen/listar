import 'package:flutter/cupertino.dart';
import 'package:listar_flutter/utils/utils.dart';

class CategoryModel {
  final int id;
  final String title;
  final int count;
  final String image;
  final IconData icon;
  final Color color;

  CategoryModel({
    required this.id,
    required this.title,
    required this.count,
    required this.image,
    required this.icon,
    required this.color,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final icon = UtilIcon.getIconData(json['icon'] ?? "Unknown");
    final color = UtilColor.getColorFromHex(json['color'] ?? "#ff8a65");
    return CategoryModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown',
      count: json['count'] ?? 0,
      image: json['image'] ?? 'Unknown',
      icon: icon,
      color: color,
    );
  }
}
