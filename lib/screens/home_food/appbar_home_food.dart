import 'package:flutter/material.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';

class AppBarHomeFood extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final List<CountryModel>? country;
  final CountryModel? countrySelected;
  final VoidCallback onNotification;
  final VoidCallback onLocation;
  final VoidCallback onSearch;

  AppBarHomeFood({
    required this.maxHeight,
    required this.minHeight,
    this.country,
    this.countrySelected,
    required this.onNotification,
    required this.onLocation,
    required this.onSearch,
  });

  ///Build Action
  Widget _buildAction(BuildContext context) {
    if (countrySelected != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onLocation,
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: Theme.of(context).primaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    countrySelected!.title,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  size: 24,
                  color: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
          InkWell(
            onTap: onNotification,
            child: Stack(
              children: [
                const Icon(Icons.notifications_none_outlined),
                Positioned(
                  top: 1,
                  right: 1,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                      border: Border.all(
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      );
    }

    return const SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(strokeWidth: 1.5),
    );
  }

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    double marginSearch = 16 + shrinkOffset;
    if (marginSearch >= 56) {
      marginSearch = 56;
    }
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: Theme.of(context).backgroundColor,
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: _buildAction(context),
                )
              ],
            ),
          ),
        ),
        SafeArea(
          top: false,
          bottom: false,
          child: Container(
            margin: EdgeInsets.only(
              bottom: 8,
              top: 8,
              left: 16,
              right: marginSearch,
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).cardColor,
              ),
              child: IntrinsicHeight(
                child: InkWell(
                  onTap: onSearch,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          Translate.of(context).translate(
                            'search_event',
                          ),
                          style: Theme.of(context).textTheme.caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: VerticalDivider(),
                      ),
                      Icon(
                        Icons.location_on,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
