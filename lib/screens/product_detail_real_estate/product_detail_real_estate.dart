import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailRealEstate extends StatefulWidget {
  const ProductDetailRealEstate({Key? key, this.id = 0}) : super(key: key);

  final int id;

  @override
  _ProductDetailRealEstateState createState() {
    return _ProductDetailRealEstateState();
  }
}

class _ProductDetailRealEstateState extends State<ProductDetailRealEstate> {
  final _currency = String.fromCharCode(0x24);
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  CameraPosition _initPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  bool _favorite = false;
  ProductDetailRealEstatePageModel? _detailPage;

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
        _detailPage = ProductDetailRealEstatePageModel.fromJson(result.data);
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
          infoWindow: InfoWindow(title: _detailPage?.product.title),
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
  void _onProductDetail(ProductRealEstateModel item) {
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

  ///Build Content
  Widget _buildContent() {
    if (_detailPage != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _detailPage!.product.subtitle,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '$_currency${_detailPage!.product.price}',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _detailPage!.product.title,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            _detailPage!.product.address,
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              AppTag(
                "${_detailPage!.product.rate}",
                type: TagType.rate,
                onPressed: _onReview,
              ),
              const SizedBox(width: 4),
              InkWell(
                onTap: _onReview,
                child: RatingBar.builder(
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
              ),
              const SizedBox(width: 4),
              Text(
                '(${_detailPage!.product.numRate})',
                style: Theme.of(context).textTheme.caption,
              )
            ],
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
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor,
                      ),
                      child: Icon(
                        UtilIcon.getIconData(item.icon),
                        size: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
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
            Translate.of(context).translate('let_find_more_location'),
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(height: 8),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = _detailPage!.product.nearly[index];
              return AppProductRealEstateItem(
                item: item,
                onPressed: () {
                  _onProductDetail(item);
                },
                type: ProductViewType.cardLarge,
              );
            },
            separatorBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Divider(),
              );
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
              background: AppSwiper(
                images: _detailPage?.product.photo,
                alignment: Alignment.bottomCenter,
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
