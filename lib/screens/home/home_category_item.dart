import 'package:flutter/material.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/widgets/app_placeholder.dart';

class HomeCategoryItem extends StatelessWidget {
  final CategoryModel? item;
  final VoidCallback? onPressed;

  const HomeCategoryItem({
    Key? key,
    this.item,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item == null) {
      return AppPlaceholder(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.21,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.21,
      child: InkWell(
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: item!.color,
              ),
              child: Icon(
                item!.icon,
                size: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item!.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
