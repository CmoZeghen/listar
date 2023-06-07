import 'model.dart';

class NotificationModel {
  final int id;
  final String title;
  final String subtitle;
  final DateTime date;
  final CategoryModel category;

  NotificationModel(
    this.id,
    this.title,
    this.subtitle,
    this.date,
    this.category,
  );

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      json['id'] ?? 0,
      json['title'] ?? '',
      json['subtitle'] ?? '',
      DateTime.tryParse(json['date']) ?? DateTime.now(),
      CategoryModel.fromJson(json['category']),
    );
  }
}
