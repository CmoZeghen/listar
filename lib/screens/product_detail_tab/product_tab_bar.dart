import 'package:flutter/material.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class ProductTabBar extends SliverPersistentHeaderDelegate {
  final double height;
  final ScrollController tabController;
  final ValueChanged<int> onIndexChanged;
  final List<TabModel>? tab;
  final int indexTab;

  ProductTabBar({
    required this.height,
    required this.tabController,
    required this.onIndexChanged,
    this.tab,
    required this.indexTab,
  });

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    if (tab == null) {
      return SafeArea(
        top: false,
        bottom: false,
        child: AppPlaceholder(
          child: Container(
            color: Colors.white,
            margin: const EdgeInsets.only(left: 16, right: 16),
          ),
        ),
      );
    }

    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView.builder(
          controller: tabController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final item = tab![index];
            final active = indexTab == index;
            return InkWell(
              onTap: () {
                onIndexChanged(index);
              },
              child: Container(
                key: item.keyTabItem,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 3,
                padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: active
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).dividerColor,
                      width: 3,
                    ),
                  ),
                ),
                child: Text(
                  Translate.of(context).translate(item.title),
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        fontWeight: active ? FontWeight.bold : null,
                      ),
                ),
              ),
            );
          },
          itemCount: tab!.length,
        ),
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
