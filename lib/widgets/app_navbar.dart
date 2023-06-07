import 'package:flutter/material.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';

enum PageType { map, list }

class AppNavBar extends StatelessWidget {
  final PageType pageStyle;
  final SortModel? currentSort;
  final VoidCallback onChangeSort;
  final VoidCallback onChangeView;
  final VoidCallback onFilter;
  final IconData iconModeView;

  const AppNavBar({
    Key? key,
    this.pageStyle = PageType.list,
    this.currentSort,
    required this.onChangeSort,
    required this.iconModeView,
    required this.onChangeView,
    required this.onFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget sort = Container();
    if (currentSort != null) {
      sort = Row(
        children: <Widget>[
          IconButton(
            icon: Icon(currentSort!.icon),
            onPressed: onChangeSort,
          ),
          Text(
            Translate.of(context).translate(currentSort!.title),
            style: Theme.of(context).textTheme.subtitle2,
          )
        ],
      );
    }
    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        color: Theme.of(context).cardColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            sort,
            Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(iconModeView),
                      onPressed: onChangeView,
                    ),
                    SizedBox(
                      height: 24,
                      child: VerticalDivider(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.track_changes),
                  onPressed: onFilter,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  child: Text(
                    Translate.of(context).translate('filter'),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
