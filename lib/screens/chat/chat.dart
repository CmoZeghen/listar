import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/chat_page_model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/screens/chat/chat_input/chat_input.dart';
import 'package:listar_flutter/screens/chat/chat_item.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class Chat extends StatefulWidget {
  final int id;

  const Chat({Key? key, required this.id}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _scrollController = ScrollController();

  ChatPageModel? _chatPage;
  Timer? _scrollTimer;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    super.dispose();
  }

  ///Fetch API
  void _loadData() async {
    final result = await Api.getDetailMessage(id: widget.id);
    if (result.success) {
      setState(() {
        _chatPage = ChatPageModel.fromJson(result.data);
      });
      _onScrollToBottom();
    }
  }

  ///On refresh
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  ///On Send message
  void _onSend(String text) {
    if (text.isNotEmpty) {
      final chat = MessageModel.fromJson({
        "id": 6,
        "message": text,
        "date": DateFormat.jm().format(DateTime.now()),
        "status": "sent"
      });
      setState(() {
        _chatPage!.message.add(chat);
      });
      _onScrollToBottom();
    }
  }

  ///Scroll To Bottom
  void _onScrollToBottom() {
    _scrollTimer?.cancel();
    _scrollTimer = Timer(const Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 500),
      );
    });
  }

  ///Build info Room
  Widget? _buildInfo() {
    if (_chatPage?.member == null) {
      return null;
    }

    return Row(
      children: <Widget>[
        AppGroupCircleAvatar(
          member: _chatPage!.member,
          size: 48,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _chatPage!.roomName,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                '${_chatPage!.online} ${Translate.of(context).translate('online')}',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              )
            ],
          ),
        )
      ],
    );
  }

  ///Build Content
  Widget _buildContent() {
    final media = MediaQuery.of(context);
    final keyboardHeight = media.viewInsets.bottom + media.padding.bottom;

    ///Loading
    if (_chatPage?.message == null) {
      return const Center(
        child: SizedBox(
          width: 26,
          height: 26,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Column(
      children: <Widget>[
        Expanded(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: SafeArea(
              top: false,
              bottom: false,
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _chatPage!.message.length,
                itemBuilder: (context, index) {
                  final item = _chatPage!.message[index];
                  return ChatItem(item: item);
                },
              ),
            ),
          ),
        ),
        ChatInput(
          onSend: _onSend,
          keyboardHeight: keyboardHeight,
          minimum: media.padding.bottom,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [GestureType.onTap, GestureType.onPanUpdateDownDirection],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: _buildInfo(),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.phone_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.videocam_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert_outlined),
              onPressed: () {},
            ),
          ],
        ),
        body: _buildContent(),
      ),
    );
  }
}
