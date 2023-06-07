import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/translate.dart';
import 'package:listar_flutter/widgets/widget.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailEvent extends StatefulWidget {
  const ProductDetailEvent({Key? key, this.id = 0}) : super(key: key);

  final int id;

  @override
  _ProductDetailEventState createState() {
    return _ProductDetailEventState();
  }
}

class _ProductDetailEventState extends State<ProductDetailEvent> {
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  CameraPosition _initPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  bool _favorite = false;
  ProductDetailEventPageModel? _detailPage;

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
        _detailPage = ProductDetailEventPageModel.fromJson(result.data);
        _favorite = _detailPage!.product.favorite;
        _initPosition = CameraPosition(
          target: LatLng(
            _detailPage!.product.location!.lat,
            _detailPage!.product.location!.long,
          ),
          zoom: 15.4746,
        );
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
  void _onProductDetail(ProductEventModel item) {
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

  ///Make action
  Future<void> _makeAction(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
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

  ///Build Rating
  Widget _buildRating() {
    if (_detailPage != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: _onReview,
                child: Row(
                  children: <Widget>[
                    AppTag(
                      "${_detailPage!.product.rate}",
                      type: TagType.rate,
                    ),
                    const SizedBox(width: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _detailPage!.product.rateText,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
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
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${_detailPage!.product.numRate} ${Translate.of(context).translate('reviews')}",
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              )
            ],
          )
        ],
      );
    }
    return Container();
  }

  ///Build Content
  Widget _buildContent() {
    if (_detailPage != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _detailPage!.product.title,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat(
                              'MMM',
                              AppLanguage.defaultLanguage.languageCode,
                            ).format(_detailPage!.product.date),
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                          Text(
                            DateFormat(
                              'dd',
                              AppLanguage.defaultLanguage.languageCode,
                            ).format(_detailPage!.product.date),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat(
                            'EEEE',
                            AppLanguage.defaultLanguage.languageCode,
                          ).format(_detailPage!.product.date),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _detailPage!.product.time,
                          style: Theme.of(context).textTheme.button!.copyWith(
                              color: Theme.of(context).colorScheme.secondary),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(width: 16),
              InkWell(
                onTap: () {},
                borderRadius: const BorderRadius.all(
                  Radius.circular(14),
                ),
                child: Container(
                  height: 28,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(14),
                    ),
                  ),
                  child: Text(
                    "Book Now",
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.5,
                        color: Colors.white,
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                          _detailPage!.product.userFavorite[0].image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.5,
                        color: Colors.white,
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                          _detailPage!.product.userFavorite[1].image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(left: 40),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.5,
                        color: Colors.white,
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                          _detailPage!.product.userFavorite[2].image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _detailPage!.product.userFavorite
                          .map((item) {
                            return item.nickname;
                          })
                          .toList()
                          .join(","),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'and 15 people like this',
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 24),
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
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 24),
          Text(
            Translate.of(context).translate('description'),
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            _detailPage!.product.description,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(height: 1.3),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: GoogleMap(
              initialCameraPosition: _initPosition,
              myLocationButtonEnabled: false,
              markers: Set<Marker>.of(_markers.values),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            Translate.of(context).translate('nearly'),
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            Translate.of(context).translate('let_find_more_event'),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 8),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = _detailPage!.product.nearly[index];
              return AppProductEventItem(
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
            itemCount: _detailPage!.product.nearly.length,
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
            expandedHeight: 200.0,
            pinned: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(_favorite ? Icons.favorite : Icons.favorite_border),
                onPressed: _onFavorite,
              ),
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
              background: Stack(
                children: [
                  AppSwiper(
                    images: _detailPage?.product.photo,
                    alignment: Alignment.bottomCenter,
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: SafeArea(
                      top: false,
                      bottom: false,
                      child: _buildRating(),
                    ),
                  )
                ],
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
