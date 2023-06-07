import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';

class SendMessage extends StatelessWidget {
  final MessageModel item;

  const SendMessage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? message = Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        item.message,
        style: Theme.of(context).textTheme.bodyText1!.apply(
              color: Colors.white,
            ),
      ),
    );
    DecorationImage? decorationImage;
    if (item.file != null) {
      decorationImage = DecorationImage(
        image: AssetImage(
          item.file!.path,
        ),
        fit: BoxFit.cover,
      );
      message = null;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            DateFormat(
              'EEE MMM d yyyy',
              AppLanguage.defaultLanguage.languageCode,
            ).format(item.date),
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(width: 8),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * .5,
              maxHeight: MediaQuery.of(context).size.width * .3,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
              image: decorationImage,
            ),
            child: message,
          ),
        ],
      ),
    );
  }
}
