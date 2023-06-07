import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetail extends StatefulWidget {
  final int id;
  const ProductDetail({
    Key? key,
    this.id = 0,
  }) : super(key: key);

  @override
  _ProductDetailState createState() {
    return _ProductDetailState();
  }
}

class _ProductDetailState extends State<ProductDetail> {
  bool _favorite = false;
  bool _showHour = true;

  ProductDetailPageModel? _detailPage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///Fetch API
  void _loadData() async {
    final result = await Api.getProductDetail(id: widget.id);
    if (result.success) {
      setState(() {
        _detailPage = ProductDetailPageModel.fromJson(result.data);
        _favorite = _detailPage!.product.favorite;
      });
    }
  }

  ///On navigate gallery
  void _onPhotoPreview() {
    Navigator.pushNamed(
      context,
      Routes.gallery,
      arguments: _detailPage!.product,
    );
  }

  ///On navigate map
  void _onLocation() {
    Navigator.pushNamed(
      context,
      Routes.location,
      arguments: _detailPage!.product.location,
    );
  }

  ///On navigate product detail
  void _onProductDetail(ProductModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
  }

  ///On navigate review
  void _onReview() {
    Navigator.pushNamed(
      context,
      Routes.review,
      arguments: _detailPage!.product,
    );
  }

  ///On like product
  void _onFavorite() {
    setState(() {
      _favorite = !_favorite;
    });
  }

  ///Phone action
  void _phoneAction(String phone) async {
    final result = await showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: IntrinsicHeight(
              child: Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    Column(
                      children: [
                        AppListTitle(
                          title: 'WhatsApp',
                          leading: SizedBox(
                            height: 32,
                            width: 32,
                            child: Image.asset(Images.whatsapp),
                          ),
                          onPressed: () {
                            Navigator.pop(context, "WhatsApp");
                          },
                        ),
                        AppListTitle(
                          title: 'Viber',
                          leading: SizedBox(
                            height: 32,
                            width: 32,
                            child: Image.asset(Images.viber),
                          ),
                          onPressed: () {
                            Navigator.pop(context, "Viber");
                          },
                        ),
                        AppListTitle(
                          title: 'Telegram',
                          leading: SizedBox(
                            height: 32,
                            width: 32,
                            child: Image.asset(Images.telegram),
                          ),
                          onPressed: () {
                            Navigator.pop(context, "Telegram");
                          },
                          border: false,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    if (result != null) {
      String url = '';

      switch (result) {
        case "WhatsApp":
          url = "whatsapp://api.whatsapp.com/send?phone=$phone";
          break;
        case "Viber":
          url = "viber://contact?number=$phone";
          break;
        case "Telegram":
          url = "tg://msg?to=$phone";
          break;
        default:
          break;
      }

      _makeAction(url);
    }
  }

  ///Make action
  void _makeAction(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  ///Build banner UI
  Widget _buildBanner() {
    if (_detailPage == null) {
      return AppPlaceholder(
        child: Container(
          color: Colors.white,
        ),
      );
    }

    return Image.asset(
      _detailPage!.product.image,
      fit: BoxFit.cover,
    );
  }

  ///Build info
  Widget _buildInfo() {
    if (_detailPage == null) {
      return AppPlaceholder(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 16),
              Container(
                height: 10,
                width: 150,
                color: Colors.white,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
                        height: 24,
                        width: 150,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Container(
                    height: 10,
                    width: 100,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
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
                        width: 200,
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
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
                        width: 200,
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
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
                        width: 200,
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
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
                        width: 200,
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
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
                        width: 200,
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 24),
              Container(height: 10, color: Colors.white),
              const SizedBox(height: 4),
              Container(height: 10, color: Colors.white),
              const SizedBox(height: 4),
              Container(height: 10, color: Colors.white),
              const SizedBox(height: 4),
              Container(height: 10, color: Colors.white),
              const SizedBox(height: 4),
              Container(height: 10, color: Colors.white),
              const SizedBox(height: 4),
              Container(height: 10, color: Colors.white),
              const SizedBox(height: 4),
              Container(height: 10, width: 50, color: Colors.white)
            ],
          ),
        ),
      );
    }

    Widget status = Container();
    if (_detailPage!.product.status.isNotEmpty) {
      status = AppTag(
        _detailPage!.product.status,
        type: TagType.status,
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _detailPage!.product.title,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(
                  _favorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: _onFavorite,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: _onReview,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _detailPage!.product.subtitle,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        AppTag(
                          "${_detailPage!.product.rate}",
                          type: TagType.rate,
                        ),
                        const SizedBox(width: 4),
                        RatingBar.builder(
                          initialRating: _detailPage!.product.rate,
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
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "(${_detailPage!.product.numRate})",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              status,
            ],
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              _makeAction(
                'https://www.google.com/maps/search/?api=1&query=${_detailPage!.product.location!.lat},${_detailPage!.product.location!.long}',
              );
            },
            child: Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).dividerColor,
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        Translate.of(context).translate('address'),
                        maxLines: 1,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        _detailPage!.product.address,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              _phoneAction(_detailPage!.product.phone);
            },
            child: Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).dividerColor,
                  ),
                  child: const Icon(
                    Icons.phone,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        Translate.of(context).translate('phone'),
                        maxLines: 1,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        _detailPage!.product.phone,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              _makeAction('mailto:${_detailPage!.product.email}');
            },
            child: Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).dividerColor,
                  ),
                  child: const Icon(
                    Icons.email,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        Translate.of(context).translate('email'),
                        maxLines: 1,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        _detailPage!.product.email,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              _makeAction(_detailPage!.product.website);
            },
            child: Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).dividerColor,
                  ),
                  child: const Icon(
                    Icons.language,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        Translate.of(context).translate('website'),
                        maxLines: 1,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        _detailPage!.product.website,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              setState(() {
                _showHour = !_showHour;
              });
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).dividerColor,
                        ),
                        child: const Icon(
                          Icons.access_time,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            Translate.of(context).translate('open_time'),
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Text(
                            _detailPage!.product.hour,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  _showHour
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          Visibility(
            visible: _showHour,
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = _detailPage!.product.hourDetail![index];
                return Container(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        Translate.of(context).translate(item.title),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        item.time == 'day_off'
                            ? Translate.of(context).translate('day_off')
                            : item.time,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: _detailPage!.product.hourDetail!.length,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _detailPage!.product.description,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(height: 1.3),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    Translate.of(context).translate('date_established'),
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _detailPage!.product.createDate,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    Translate.of(context).translate('price_range'),
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _detailPage!.product.priceRange,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Translate.of(context).translate('facilities'),
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _detailPage!.product.service.map((item) {
                  return IntrinsicWidth(
                    child: AppTag(
                      item.title,
                      type: TagType.chip,
                      icon: Icon(
                        UtilIcon.getIconData(item.icon),
                        size: 12,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///Build list feature
  Widget _buildFeature() {
    if (_detailPage == null) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Text(
            Translate.of(context).translate('featured'),
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16),
            itemBuilder: (context, index) {
              final ProductModel item = _detailPage!.product.feature[index];
              return Container(
                width: MediaQuery.of(context).size.width / 2,
                padding: const EdgeInsets.only(right: 16),
                child: AppProductItem(
                  onPressed: () {
                    _onProductDetail(item);
                  },
                  item: item,
                  type: ProductViewType.gird,
                ),
              );
            },
            itemCount: _detailPage!.product.feature.length,
          ),
        )
      ],
    );
  }

  ///Build list related
  Widget _buildRelated() {
    if (_detailPage == null) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            Translate.of(context).translate('related'),
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Column(
            children: _detailPage!.product.related.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: AppProductItem(
                  onPressed: () {
                    _onProductDetail(item);
                  },
                  item: item,
                  type: ProductViewType.small,
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.map_outlined),
                onPressed: _onLocation,
              ),
              IconButton(
                icon: const Icon(Icons.photo_library_outlined),
                onPressed: _onPhotoPreview,
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: _buildBanner(),
            ),
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: AppUserInfo(
                        user: _detailPage?.product.author,
                        onPressed: () {},
                        type: AppUserType.basic,
                      ),
                    ),
                    _buildInfo(),
                    _buildFeature(),
                    _buildRelated()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
