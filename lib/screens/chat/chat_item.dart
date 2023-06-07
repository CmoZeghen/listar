import 'package:flutter/material.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/screens/chat/receive_message.dart';
import 'package:listar_flutter/screens/chat/send_message.dart';

class ChatItem extends StatelessWidget {
  final MessageModel item;

  const ChatItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item.from == null) {
      return SendMessage(item: item);
    }
    return ReceiveMessage(item: item);
  }
}
