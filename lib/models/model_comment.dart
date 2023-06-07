import 'package:listar_flutter/models/model.dart';

class CommentModel {
  final int id;
  final UserModel user;
  final String title;
  final String comment;
  final String createDate;
  final double rate;

  CommentModel(
    this.id,
    this.user,
    this.title,
    this.comment,
    this.createDate,
    this.rate,
  );

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      json['id'] ?? 0,
      UserModel.fromJson(json['user']),
      json['title'] ?? 'Unknown',
      json['comment'] ?? 'Unknown',
      json['created_date'] ?? 'Unknown',
      json['rate'] ?? 0.0,
    );
  }
}
