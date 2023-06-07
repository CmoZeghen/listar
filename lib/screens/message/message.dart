import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/app_message_item.dart';
import 'package:listar_flutter/widgets/widget.dart';

import 'search.dart';

class MessageList extends StatefulWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  _MessageListState createState() {
    return _MessageListState();
  }
}

class _MessageListState extends State<MessageList> {
  MessageSearchDelegate? _delegate;
  MessagePageModel? _messagePage;

  @override
  void initState() {
    super.initState();
    _delegate = MessageSearchDelegate();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///Fetch API
  void _loadData() async {
    final result = await Api.getMessage();
    if (result.success) {
      setState(() {
        _messagePage = MessagePageModel.fromJson(result.data);
      });
    }
  }

  ///On search
  void _onSearch() {
    showSearch(
      context: context,
      delegate: _delegate!,
    );
  }

  ///On refresh
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  ///On navigate chat screen
  void _onChat(MessageModel item) {
    Navigator.pushNamed(context, Routes.chat, arguments: item.id);
  }

  ///Build list
  Widget _buildList() {
    if (_messagePage == null) {
      return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: 8,
        itemBuilder: (context, index) {
          return const AppMessageItem();
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _messagePage!.message.length,
        itemBuilder: (context, index) {
          final item = _messagePage!.message[index];
          return AppMessageItem(
            item: item,
            onPressed: () {
              _onChat(item);
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.search),
          onPressed: _onSearch,
        ),
        titleSpacing: 0,
        title: InkWell(
          onTap: _onSearch,
          child: Text(
            Translate.of(context).translate('search_room'),
            maxLines: 1,
            style: Theme.of(context).primaryTextTheme.button,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert_outlined),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: _buildList(),
      ),
    );
  }
}
