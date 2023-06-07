import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/widgets/widget.dart';

class ReceiveMessage extends StatelessWidget {
  final MessageModel item;

  const ReceiveMessage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? message = Text(
      item.message,
      style: Theme.of(context).textTheme.bodyText2,
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
        children: <Widget>[
          AppCircleAvatar(imgUrl: item.from!.image),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.from!.name,
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(height: 8),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .5,
                    maxHeight: MediaQuery.of(context).size.height * .3,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).hoverColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(24),
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                    image: decorationImage,
                  ),
                  child: message,
                ),
              ],
            ),
          ),
          Text(
            DateFormat(
              'EEE MMM d yyyy',
              AppLanguage.defaultLanguage.languageCode,
            ).format(item.date),
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
