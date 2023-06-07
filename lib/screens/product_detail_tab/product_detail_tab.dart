import 'dart:async';

import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/widgets/widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'product_extend_header.dart';
import 'product_tab_bar.dart';
import 'product_tab_content.dart';

const appBarHeight = 200.0;
const expandedBarHeight = 150.0;
const tabHeight = 50.0;

class ProductDetailTab extends StatefulWidget {
  const ProductDetailTab({Key? key, this.id = 0}) : super(key: key);

  final int id;

  @override
  _ProductDetailTabState createState() {
    return _ProductDetailTabState();
  }
}

class _ProductDetailTabState extends State<ProductDetailTab> {
  final _tabController = ScrollController();
  final _scrollController = ScrollController();

  bool _favorite = false;
  List<double> _offsetContentOrigin = [];
  int _indexTab = 0;
  ProductDetailPageModel? _pageDetail;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  ///Fetch API
  void _loadData() async {
    final result = await Api.getProductDetail(
      id: widget.id,
    );
    if (result.success) {
      setState(() {
        _pageDetail = ProductDetailPageModel.fromJson(result.data);
      });
      Timer(const Duration(milliseconds: 200), () {
        _setOriginOffset();
      });
    }
  }

  ///ScrollListenerEvent
  void _scrollListener() {
    if (_pageDetail?.tab != null) {
      int activeTab = 0;
      double? offsetTab;
      double widthDevice = MediaQuery.of(context).size.width;
      double itemSize = widthDevice / 3;
      double offsetStart = widthDevice / 2 - itemSize / 2;

      int indexCheck = _offsetContentOrigin.indexWhere((item) {
        return item - 1 > _scrollController.offset;
      });
      if (indexCheck == -1) {
        activeTab = _offsetContentOrigin.length - 1;
        offsetTab = offsetStart + itemSize * (activeTab - 3);
      } else if (indexCheck > 0) {
        activeTab = indexCheck - 1 > 0 ? indexCheck - 1 : 0;
        offsetTab =
            activeTab > 1 ? offsetStart + itemSize * (activeTab - 2) : 0;
      }

      if (activeTab != _indexTab) {
        setState(() {
          _indexTab = activeTab;
        });
      }
      if (offsetTab != null) {
        _tabController.jumpTo(offsetTab);
      }
    }
  }

  ///Set Origin Offset default when render success
  void _setOriginOffset() {
    if (_pageDetail?.tab != null && _offsetContentOrigin.isEmpty) {
      setState(() {
        _offsetContentOrigin = _pageDetail!.tab!.map((item) {
          final box = item.keyContentItem.currentContext!.findRenderObject()
              as RenderBox;
          final position = box.localToGlobal(Offset.zero);
          return position.dy +
              _scrollController.offset -
              tabHeight -
              AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top;
        }).toList();
      });
    }
  }

  ///On Change tab jumpTo offset
  ///Scroll controller will handle setState active tab
  void _onChangeTab(int index) {
    if (_offsetContentOrigin.isNotEmpty) {
      _scrollController.animateTo(
        _offsetContentOrigin[index] + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  ///On navigate gallery
  void _onPhotoPreview() {
    Navigator.pushNamed(
      context,
      Routes.gallery,
      arguments: _pageDetail!.product,
    );
  }

  ///On navigate map
  void _onLocation() {
    Navigator.pushNamed(
      context,
      Routes.location,
      arguments: _pageDetail?.product.location,
    );
  }

  ///On navigate review
  void _onReview() {
    Navigator.pushNamed(
      context,
      Routes.review,
      arguments: _pageDetail!.product,
    );
  }

  ///On navigate product detail
  void _onProductDetail(ProductModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
  }

  ///On like product
  void _onFavorite() {
    setState(() {
      _favorite = !_favorite;
    });
  }

  ///Make action
  void _makeAction(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  ///Build banner UI
  Widget _buildBanner() {
    if (_pageDetail == null) {
      return AppPlaceholder(
        child: Container(
          color: Colors.white,
        ),
      );
    }

    return Image.asset(
      _pageDetail!.product.image,
      fit: BoxFit.cover,
    );
  }

  ///Build Tab Content UI
  Widget _buildTabContent() {
    if (_pageDetail == null) {
      return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: AppPlaceholder(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(8, (index) => index).map(
              (item) {
                return Column(
                  children: <Widget>[
                    const SizedBox(height: 8),
                    Container(height: 32, color: Colors.white),
                  ],
                );
              },
            ).toList(),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _pageDetail!.tab!.map((item) {
        return TabContent(
          item: item,
          page: _pageDetail!,
          onProductDetail: _onProductDetail,
          makeAction: _makeAction,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: appBarHeight,
            pinned: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.map_outlined),
                onPressed: _onLocation,
              ),
              IconButton(
                icon: const Icon(Icons.photo_outlined),
                onPressed: _onPhotoPreview,
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: _buildBanner(),
            ),
          ),
          SliverPersistentHeader(
            pinned: false,
            floating: false,
            delegate: ProductHeader(
              height: expandedBarHeight,
              productTabPage: _pageDetail,
              like: _favorite,
              onPressLike: _onFavorite,
              onPressReview: _onReview,
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: ProductTabBar(
              height: tabHeight,
              tabController: _tabController,
              onIndexChanged: _onChangeTab,
              indexTab: _indexTab,
              tab: _pageDetail?.tab,
            ),
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              top: false,
              child: _buildTabContent(),
            ),
          )
        ],
      ),
    );
  }
}
