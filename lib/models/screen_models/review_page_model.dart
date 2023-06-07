import 'package:listar_flutter/models/model.dart';

class ReviewPageModel {
  final RateModel rate;
  final List<CommentModel> comment;

  ReviewPageModel({
    required this.rate,
    required this.comment,
  });

  factory ReviewPageModel.fromJson(Map<String, dynamic> json) {
    return ReviewPageModel(
      rate: RateModel.fromJson(json['rate']),
      comment: List.from(json['comment'] ?? []).map((item) {
        return CommentModel.fromJson(item);
      }).toList(),
    );
  }
}
