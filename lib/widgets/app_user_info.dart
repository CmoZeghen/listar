import 'package:flutter/material.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/widgets/widget.dart';

enum AppUserType { basic, information }

class AppUserInfo extends StatelessWidget {
  final UserModel? user;
  final VoidCallback? onPressed;
  final AppUserType type;

  const AppUserInfo({
    Key? key,
    this.user,
    this.onPressed,
    this.type = AppUserType.basic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      switch (type) {
        case AppUserType.information:
          return AppPlaceholder(
            child: Row(
              children: <Widget>[
                Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: 14,
                      height: 14,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 10,
                        width: 100,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 10,
                        width: 100,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 10,
                        width: 150,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        default:
          return AppPlaceholder(
            child: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 10,
                      width: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 10,
                      width: 150,
                      color: Colors.white,
                    ),
                  ],
                )
              ],
            ),
          );
      }
    }

    switch (type) {
      case AppUserType.information:
        return InkWell(
          onTap: onPressed,
          child: Row(
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(user!.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      "${user!.rate}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      user!.name,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user!.description,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user!.tag,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              RotatedBox(
                quarterTurns: AppLanguage.isRTL() ? 2 : 0,
                child: const Icon(
                  Icons.keyboard_arrow_right,
                ),
              )
            ],
          ),
        );
      default:
        return Row(
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    user!.image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  user!.name,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  user!.description,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            )
          ],
        );
    }
  }
}
