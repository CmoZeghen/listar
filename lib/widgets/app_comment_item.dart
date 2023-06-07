import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/widgets/widget.dart';

class AppCommentItem extends StatelessWidget {
  final CommentModel? item;

  const AppCommentItem({Key? key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item == null) {
      return AppPlaceholder(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 10,
                              width: 150,
                              color: Colors.white,
                            ),
                            Container(
                              height: 10,
                              width: 50,
                              color: Colors.white,
                            )
                          ],
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 10,
                          width: 50,
                          color: Colors.white,
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 4),
              Container(
                height: 10,
                width: 100,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Container(
                height: 10,
                color: Colors.white,
              ),
              const SizedBox(height: 4),
              Container(
                height: 10,
                color: Colors.white,
              ),
              const SizedBox(height: 4),
              Container(
                height: 10,
                color: Colors.white,
              ),
              const SizedBox(height: 4),
              Container(
                height: 10,
                color: Colors.white,
              ),
              const SizedBox(height: 4),
              Container(
                height: 10,
                color: Colors.white,
              )
            ],
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(item!.user.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            item!.user.name,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          item!.createDate,
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
                    RatingBar.builder(
                      initialRating: item!.rate,
                      minRating: 1,
                      allowHalfRating: true,
                      unratedColor: Colors.amber.withAlpha(100),
                      itemCount: 5,
                      itemSize: 14.0,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      ignoreGestures: true,
                      onRatingUpdate: (double value) {},
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 4),
          Text(
            item!.title,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            item!.comment,
            maxLines: 5,
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }
}
