import 'package:flutter/material.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class AppProfilePerformance extends StatelessWidget {
  final UserModel? user;

  const AppProfilePerformance({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [1, 2, 3].map((item) {
          return AppPlaceholder(
            child: Column(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 10,
                  color: Colors.white,
                ),
                const SizedBox(height: 4),
                Container(
                  width: 50,
                  height: 10,
                  color: Colors.white,
                ),
              ],
            ),
          );
        }).toList(),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: user!.values.map((item) {
        return Column(
          children: <Widget>[
            Text(
              '${item['value']}',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              Translate.of(context).translate('${item['title']}'),
              style: Theme.of(context).textTheme.caption,
            )
          ],
        );
      }).toList(),
    );
  }
}
