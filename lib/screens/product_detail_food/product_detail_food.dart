import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailFood extends StatefulWidget {
  const ProductDetailFood({Key? key, this.id = 0}) : super(key: key);

  final int id;

  @override
  _ProductDetailFoodState createState() {
    return _ProductDetailFoodState();
  }
}

class _ProductDetailFoodState extends State<ProductDetailFood> {
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  bool _favorite = false;
  ProductDetailFoodPageModel? _detailPage;

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
        _detailPage = ProductDetailFoodPageModel.fromJson(result.data);
        _favorite = _detailPage!.product.favorite;
        final markerID = MarkerId(_detailPage!.product.id.toString());
        final marker = Marker(
          markerId: markerID,
          position: LatLng(
            _detailPage!.product.location!.lat,
            _detailPage!.product.location!.long,
          ),
          infoWindow: InfoWindow(title: _detailPage!.product.title),
        );
        _markers[markerID] = marker;
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

  ///On Share
  void _onShare() async {
    await Share.share(
      'https://codecanyon.net/item/listar-flux-mobile-directory-listing-app-template-for-flutter/25559387',
      subject: 'Listar Flux',
    );
  }

  ///On navigate product detail
  void _onProductDetail(ProductFoodModel item) {
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

  ///On navigate chat screen
  void _onChat() {
    Navigator.pushNamed(context, Routes.chat, arguments: 3);
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
  Future<void> _makeAction(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  ///Build Card
  Widget _buildCard() {
    if (_detailPage != null) {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 60),
            child: AppSwiper(
              images: _detailPage?.product.photo,
              alignment: const Alignment(0.0, 0.4),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            padding: const EdgeInsets.all(16),
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.2),
                  blurRadius: 2,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _detailPage!.product.title,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _detailPage!.product.status,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: _onReview,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.9),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${_detailPage!.product.rate}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                          Text(
                            _detailPage!.product.distance,
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                          Text(
                            _detailPage!.product.subtitle,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _detailPage!.product.promotion,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    InkWell(
                      child: Icon(
                        _favorite ? Icons.favorite : Icons.favorite_border,
                        color: Theme.of(context).primaryColor,
                      ),
                      onTap: _onFavorite,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      );
    }

    return AppPlaceholder(
      child: Container(
        color: Colors.white,
      ),
    );
  }

  ///Build Content
  Widget _buildContent() {
    if (_detailPage != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(_detailPage!.product.author!.image),
                        ),
                        border: Border.all(
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _detailPage!.product.author!.name,
                            style: Theme.of(context).textTheme.button,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _detailPage!.product.author!.description,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: _onChat,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor.withOpacity(.8),
                      ),
                      child: const Icon(
                        Icons.message,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      _phoneAction(_detailPage!.product.phone);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor.withOpacity(.8),
                      ),
                      child: const Icon(
                        Icons.call,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Text(
            Translate.of(context).translate('related'),
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            Translate.of(context).translate('let_find_interesting'),
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(height: 8),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = _detailPage!.product.related[index];
              return AppProductFoodItem(
                item: item,
                onPressed: () {
                  _onProductDetail(item);
                },
                type: ProductViewType.small,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
            itemCount: _detailPage!.product.related.length,
          ),
        ],
      );
    }

    ///Loading
    return AppPlaceholder(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 16, color: Colors.white),
          const SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          const SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          const SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          const SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          const SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          const SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          const SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          const SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          const SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          const SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          const SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
          const SizedBox(height: 16),
          Container(height: 16, color: Colors.white),
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
            expandedHeight: 260.0,
            pinned: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: _onShare,
              ),
              IconButton(
                icon: const Icon(Icons.photo_library_outlined),
                onPressed: _onPhotoPreview,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Container(
                color: Theme.of(context).backgroundColor,
                child: _buildCard(),
              ),
            ),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildContent(),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
