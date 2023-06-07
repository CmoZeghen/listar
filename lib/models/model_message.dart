import 'dart:io';

import 'package:listar_flutter/models/model.dart';

enum Status { sent, received }

class MessageModel {
  final int id;
  final String roomName;
  final List<UserModel> member;
  final UserModel? from;
  final String message;
  final DateTime date;
  final Status status;
  final File? file;

  MessageModel({
    required this.id,
    required this.roomName,
    required this.member,
    this.from,
    required this.message,
    required this.date,
    required this.status,
    this.file,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    Status status = Status.sent;
    File? file;
    UserModel? from;

    if (json['status'] == 'received') {
      status = Status.received;
    }

    if (json['file'] != null) {
      file = File(json['file']);
    }

    if (json['from'] != null) {
      from = UserModel.fromJson(json['from']);
    }
    return MessageModel(
      id: json['id'] ?? 0,
      roomName: json['room_name'] ?? '',
      member: List.from(json['member'] ?? []).map((item) {
        return UserModel.fromJson(item);
      }).toList(),
      from: from,
      message: json['message'] ?? '',
      date: DateTime.tryParse(json['date']) ?? DateTime.now(),
      status: status,
      file: file,
    );
  }
}
