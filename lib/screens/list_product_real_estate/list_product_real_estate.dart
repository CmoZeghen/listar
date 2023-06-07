import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class ListProductRealEstate extends StatefulWidget {
  final CategoryModel? category;

  const ListProductRealEstate({Key? key, this.category}) : super(key: key);

  @override
  _ListProductRealEstateState createState() {
    return _ListProductRealEstateState();
  }
}

class _ListProductRealEstateState extends State<ListProductRealEstate> {
  final _swipeController = SwiperController();
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  GoogleMapController? _mapController;
  int _indexLocation = 0;
  MapType _mapType = MapType.normal;
  CameraPosition? _initPosition;
  PageType _pageType = PageType.list;
  ProductViewType _modeView = ProductViewType.gird;
  ProductListRealEstatePageModel? _productPage;
  SortModel _currentSort = ListSetting.listSortDefault.first;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  ///On Fetch API
  void _loadData() async {
    final result = await Api.getProduct();
    if (result.success) {
      final productPage = ProductListRealEstatePageModel.fromJson(result.data);

      ///Setup list marker map from list
      for (var item in productPage.list) {
        final markerId = MarkerId(item.id.toString());
        final marker = Marker(
          markerId: markerId,
          position: LatLng(item.location!.lat, item.location!.long),
          infoWindow: InfoWindow(title: item.title),
          onTap: () {
            _onSelectLocation(item);
          },
        );
        _markers[markerId] = marker;
      }

      setState(() {
        _productPage = productPage;
        _initPosition = CameraPosition(
          target: LatLng(
            productPage.list.first.location!.lat,
            productPage.list.first.location!.long,
          ),
          zoom: 14.4746,
        );
      });
    }
  }

  ///On Refresh List
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  ///On Change Sort
  void _onChangeSort() async {
    final result = await showModalBottomSheet<SortModel?>(
      context: context,
      builder: (BuildContext context) {
        return AppBottomPicker(
          picker: PickerModel(
            selected: [_currentSort],
            data: ListSetting.listSortDefault,
          ),
        );
      },
    );
    if (result != null) {
      setState(() {
        _currentSort = result;
      });
    }
  }

  ///On Change View
  void _onChangeView() {
    if (_pageType == PageType.map) {
      switch (_mapType) {
        case MapType.normal:
          _mapType = MapType.hybrid;
          break;
        case MapType.hybrid:
          _mapType = MapType.normal;
          break;
        default:
          _mapType = MapType.normal;
          break;
      }
    } else {
      switch (_modeView) {
        case ProductViewType.gird:
          _modeView = ProductViewType.list;
          break;
        case ProductViewType.list:
          _modeView = ProductViewType.block;
          break;
        case ProductViewType.block:
          _modeView = ProductViewType.gird;
          break;
        default:
          return;
      }
    }

    setState(() {
      _modeView = _modeView;
      _mapType = _mapType;
    });
  }

  ///On change filter
  void _onChangeFilter() {
    Navigator.pushNamed(context, Routes.filter);
  }

  ///On change page
  void _onChangePageStyle() {
    switch (_pageType) {
      case PageType.list:
        setState(() {
          _pageType = PageType.map;
        });
        return;
      case PageType.map:
        setState(() {
          _pageType = PageType.list;
        });
        return;
    }
  }

  ///On tap marker map location
  void _onSelectLocation(ProductRealEstateModel item) {
    final index = _productPage!.list.indexOf(item);
    _swipeController.move(index);
  }

  ///Handle Index change list map view
  void _onIndexChange(int index) {
    setState(() {
      _indexLocation = index;
    });

    ///Camera animated
    _mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 270.0,
          target: LatLng(
            _productPage!.list[_indexLocation].location!.lat,
            _productPage!.list[_indexLocation].location!.long,
          ),
          tilt: 30.0,
          zoom: 15.0,
        ),
      ),
    );
  }

  ///On navigate product detail
  void _onProductDetail(ProductRealEstateModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
  }

  ///On search
  void _onSearch() {
    Navigator.pushNamed(context, Routes.searchHistory);
  }

  ///Export Icon for Mode View
  IconData _exportIconView() {
    if (_pageType == PageType.map) {
      switch (_mapType) {
        case MapType.normal:
          return Icons.map;
        case MapType.hybrid:
          return Icons.satellite;
        default:
          return Icons.map;
      }
    }

    switch (_modeView) {
      case ProductViewType.list:
        return Icons.view_list_outlined;
      case ProductViewType.gird:
        return Icons.view_quilt_outlined;
      case ProductViewType.block:
        return Icons.view_array_outlined;
      default:
        return Icons.help_outlined;
    }
  }

  ///Widget build Content
  Widget _buildList() {
    if (_productPage == null) {
      ///Build Loading

      if (_modeView == ProductViewType.gird) {
        final deviceWidth = MediaQuery.of(context).size.width;
        const itemHeight = 230;
        final safeLeft = MediaQuery.of(context).padding.left;
        final safeRight = MediaQuery.of(context).padding.right;
        final itemWidth = (deviceWidth - 16 * 3 - safeLeft - safeRight) / 2;
        final ratio = itemWidth / itemHeight;
        return GridView.count(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          crossAxisCount: 2,
          childAspectRatio: ratio,
          children: List.generate(8, (index) => index).map((item) {
            return AppProductRealEstateItem(type: _modeView);
          }).toList(),
        );
      }

      return ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              top: 8,
              bottom: 8,
              left: _modeView == ProductViewType.list ? 16 : 0,
            ),
            child: AppProductRealEstateItem(type: _modeView),
          );
        },
        itemCount: 8,
      );
    }

    ///Build list
    if (_modeView == ProductViewType.gird) {
      final deviceWidth = MediaQuery.of(context).size.width;
      const itemHeight = 230;
      final safeLeft = MediaQuery.of(context).padding.left;
      final safeRight = MediaQuery.of(context).padding.right;
      final itemWidth = (deviceWidth - 16 * 3 - safeLeft - safeRight) / 2;
      final ratio = itemWidth / itemHeight;
      return GridView.count(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        crossAxisCount: 2,
        childAspectRatio: ratio,
        children: _productPage!.list.map((item) {
          return AppProductRealEstateItem(
            onPressed: () {
              _onProductDetail(item);
            },
            item: item,
            type: _modeView,
          );
        }).toList(),
      );
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = _productPage!.list[index];
        return Padding(
          padding: EdgeInsets.only(
            top: 8,
            bottom: 8,
            left: _modeView == ProductViewType.list ? 16 : 0,
          ),
          child: AppProductRealEstateItem(
            onPressed: () {
              _onProductDetail(item);
            },
            item: item,
            type: _modeView,
          ),
        );
      },
      itemCount: _productPage!.list.length,
    );
  }

  ///Build Content Page Style
  Widget _buildContent() {
    if (_pageType == PageType.list) {
      return SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: _buildList(),
        ),
      );
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        GoogleMap(
          onMapCreated: (controller) {
            _mapController = controller;
          },
          mapType: _mapType,
          initialCameraPosition: _initPosition!,
          markers: Set<Marker>.of(_markers.values),
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
        ),
        SafeArea(
          bottom: false,
          top: false,
          child: Container(
            height: 200,
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).dividerColor,
                            blurRadius: 5,
                            spreadRadius: 1.0,
                            offset: const Offset(1.5, 1.5),
                          )
                        ],
                      ),
                      child: const Icon(
                        Icons.directions,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                        ),
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).dividerColor,
                              blurRadius: 5,
                              spreadRadius: 1.0,
                              offset: const Offset(1.5, 1.5),
                            )
                          ],
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: Swiper(
                    itemBuilder: (context, index) {
                      final item = _productPage!.list[index];
                      return Container(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: _indexLocation == index
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).dividerColor,
                                blurRadius: 5,
                                spreadRadius: 1.0,
                                offset: const Offset(1.5, 1.5),
                              )
                            ],
                          ),
                          child: AppProductRealEstateItem(
                            onPressed: () {
                              _onProductDetail(item);
                            },
                            item: item,
                            type: ProductViewType.list,
                          ),
                        ),
                      );
                    },
                    controller: _swipeController,
                    onIndexChanged: (index) {
                      _onIndexChange(index);
                    },
                    itemCount: _productPage!.list.length,
                    viewportFraction: 0.8,
                    scale: 0.9,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.category?.title ?? Translate.of(context).translate('listing'),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _onSearch,
          ),
          Visibility(
            visible: _productPage != null,
            child: IconButton(
              icon: Icon(
                _pageType == PageType.map
                    ? Icons.view_compact_outlined
                    : Icons.map_outlined,
              ),
              onPressed: _onChangePageStyle,
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          AppNavBar(
            pageStyle: _pageType,
            currentSort: _currentSort,
            onChangeSort: _onChangeSort,
            iconModeView: _exportIconView(),
            onChangeView: _onChangeView,
            onFilter: _onChangeFilter,
          ),
          Expanded(
            child: _buildContent(),
          )
        ],
      ),
    );
  }
}
