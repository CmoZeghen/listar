import 'package:flutter/material.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class AppRating extends StatelessWidget {
  final RateModel? rate;

  const AppRating({
    Key? key,
    this.rate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (rate == null) {
      return AppPlaceholder(
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "0.0",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                Text(
                  "${Translate.of(context).translate('out_of')} 0",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [1, 2, 3, 4, 5].map((item) {
                            return const Icon(
                              Icons.star,
                              size: 12,
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).dividerColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(3),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [1, 2, 3, 4].map((item) {
                            return const Icon(
                              Icons.star,
                              size: 12,
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).dividerColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(3),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [1, 2, 3].map((item) {
                            return const Icon(
                              Icons.star,
                              size: 12,
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).dividerColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(3),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [1, 2].map((item) {
                            return const Icon(
                              Icons.star,
                              size: 12,
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).dividerColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(3),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [1].map((item) {
                            return const Icon(
                              Icons.star,
                              size: 12,
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).dividerColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(3),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Loading",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              "${rate!.avg}",
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
            Text(
              "${Translate.of(context).translate('out_of')} ${rate!.range}",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [1, 2, 3, 4, 5].map((item) {
                        return const Icon(
                          Icons.star,
                          size: 12,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(3),
                        ),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: rate!.five,
                        child: Container(
                          height: 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [1, 2, 3, 4].map((item) {
                        return const Icon(
                          Icons.star,
                          size: 12,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(3),
                        ),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: rate!.four,
                        child: Container(
                          height: 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [1, 2, 3].map((item) {
                        return const Icon(
                          Icons.star,
                          size: 12,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(3),
                        ),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: rate!.three,
                        child: Container(
                          height: 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [1, 2].map((item) {
                        return const Icon(
                          Icons.star,
                          size: 12,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(3),
                        ),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: rate!.two,
                        child: Container(
                          height: 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [1].map((item) {
                        return const Icon(
                          Icons.star,
                          size: 12,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(3),
                        ),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: rate!.one,
                        child: Container(
                          height: 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "${rate!.total} ${Translate.of(context).translate('rating')}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
