import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  _NotificationListState createState() {
    return _NotificationListState();
  }
}

class _NotificationListState extends State<NotificationList> {
  NotificationPageModel? _notificationPage;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///Fetch API
  void _loadData() async {
    final result = await Api.getNotification();
    if (result.success) {
      setState(() {
        _notificationPage = NotificationPageModel.fromJson(result.data);
      });
    }
  }

  ///On refresh
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  ///Build list
  Widget _buildList() {
    if (_notificationPage == null) {
      return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          return const AppNotificationItem();
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: 8,
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _notificationPage!.notification.length,
        itemBuilder: (context, index) {
          final item = _notificationPage!.notification[index];
          return Dismissible(
            key: Key(item.id.toString()),
            direction: DismissDirection.endToStart,
            child: AppNotificationItem(
              item: item,
              onPressed: () {},
            ),
            background: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 16, right: 16),
              color: Theme.of(context).colorScheme.secondary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const <Widget>[
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            onDismissed: (direction) {
              _notificationPage!.notification.removeAt(index);
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
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('notification'),
        ),
      ),
      body: SafeArea(
        child: _buildList(),
      ),
    );
  }
}
