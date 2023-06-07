import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

import 'appbar_home_real_estate.dart';

class HomeRealEstate extends StatefulWidget {
  const HomeRealEstate({Key? key}) : super(key: key);

  @override
  _HomeRealEstateState createState() {
    return _HomeRealEstateState();
  }
}

class _HomeRealEstateState extends State<HomeRealEstate> {
  BusinessState _business = AppBloc.businessCubit.state;

  HomeRealEstatePageModel? _homePage;
  CountryModel? _countrySelected;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On navigate list product
  void _onProductList(CategoryModel? item) {
    Navigator.pushNamed(
      context,
      Routes.listProduct,
      arguments: item,
    );
  }

  ///Fetch API
  void _loadData() async {
    final result = await Api.getHome();
    if (result.success) {
      setState(() {
        _homePage = HomeRealEstatePageModel.fromJson(result.data);
        _countrySelected = _homePage!.country.first;
      });
    }
  }

  ///On refresh
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    _loadData();
  }

  ///On navigate product detail
  void _onProductDetail(ProductRealEstateModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
  }

  ///On search
  void _onSearch() {
    Navigator.pushNamed(context, Routes.searchHistory);
  }

  ///On select country
  Future<void> _onSelectCountry() async {
    final item = await showModalBottomSheet<CountryModel?>(
      context: context,
      builder: (BuildContext context) {
        return AppBottomPicker(
          picker: PickerModel(
            data: _homePage!.country,
            selected: [_countrySelected],
          ),
        );
      },
    );
    if (item != null) {
      setState(() {
        _countrySelected = item;
      });
    }
  }

  ///Choose Business
  void _chooseBusiness() async {
    final result = await showDialog<BusinessState>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        _business = AppBloc.businessCubit.state;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                Translate.of(context).translate('choose_your_business'),
              ),
              content: SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  runSpacing: 8,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _business = BusinessState.basic;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(4),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              border: Border.all(
                                color: _exportColor(BusinessState.basic),
                                width: 2,
                              ),
                              image: const DecorationImage(
                                image: AssetImage(Images.location1),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            "Basic",
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _business = BusinessState.realEstate;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(4),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              border: Border.all(
                                color: _exportColor(BusinessState.realEstate),
                                width: 2,
                              ),
                              image: const DecorationImage(
                                image: AssetImage(Images.realEstate1),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            "Real Estate",
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _business = BusinessState.event;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(4),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              border: Border.all(
                                color: _exportColor(BusinessState.event),
                                width: 2,
                              ),
                              image: const DecorationImage(
                                image: AssetImage(Images.event1),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            "Event",
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _business = BusinessState.food;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(4),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              border: Border.all(
                                color: _exportColor(BusinessState.food),
                                width: 2,
                              ),
                              image: const DecorationImage(
                                image: AssetImage(Images.food1),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            "Food",
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                AppButton(
                  Translate.of(context).translate('close'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  type: ButtonType.text,
                ),
                AppButton(
                  Translate.of(context).translate('apply'),
                  onPressed: () {
                    Navigator.pop(context, _business);
                  },
                )
              ],
            );
          },
        );
      },
    );
    if (result != null) {
      AppBloc.businessCubit.onChangeBusiness(_business);
    }
  }

  ///Is Selected Business
  Color _exportColor(BusinessState business) {
    if (business == _business) {
      return Theme.of(context).primaryColor;
    }
    return Theme.of(context).dividerColor;
  }

  ///Build Location
  Widget _buildLocation() {
    Widget content = ListView.separated(
      padding: const EdgeInsets.only(left: 8, right: 8),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return AppPlaceholder(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  Translate.of(context).translate('loading'),
                  style: Theme.of(context).textTheme.button,
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(width: 4);
      },
      itemCount: 8,
    );

    if (_homePage != null) {
      content = ListView.separated(
        padding: const EdgeInsets.only(left: 8, right: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = _homePage!.location[index];
          return Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: InkWell(
              onTap: () {
                _onProductList(item);
              },
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(item.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.button,
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 4);
        },
        itemCount: _homePage!.location.length,
      );

      ///Empty
      if (_homePage!.location.isEmpty) {
        content = Container(
          alignment: Alignment.center,
          child: Text(
            Translate.of(context).translate('data_not_found'),
            style: Theme.of(context).textTheme.button,
          ),
        );
      }
    }

    ///Build
    return SizedBox(
      height: 80,
      child: content,
    );
  }

  ///Build Popular
  Widget _buildPopular() {
    Widget content = ListView.builder(
      padding: const EdgeInsets.only(left: 8, right: 8),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          width: 200,
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: AppProductRealEstateItem(
            type: ProductViewType.gird,
          ),
        );
      },
      itemCount: 8,
    );

    if (_homePage != null) {
      content = ListView.builder(
        padding: const EdgeInsets.only(left: 8, right: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = _homePage!.popular[index];
          return Container(
            padding: const EdgeInsets.only(left: 8, right: 8),
            width: 200,
            child: AppProductRealEstateItem(
              item: item,
              onPressed: () {
                _onProductDetail(item);
              },
              type: ProductViewType.gird,
            ),
          );
        },
        itemCount: _homePage!.popular.length,
      );

      ///Empty
      if (_homePage!.popular.isEmpty) {
        content = Container(
          alignment: Alignment.center,
          child: Text(
            Translate.of(context).translate('data_not_found'),
            style: Theme.of(context).textTheme.button,
          ),
        );
      }
    }

    ///Build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translate.of(context).translate('popular_nearest'),
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                Translate.of(context).translate('let_find_best_price'),
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 230,
          child: content,
        )
      ],
    );
  }

  ///Build Recommend
  Widget _buildRecommend() {
    Widget content = ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(left: 16, right: 16),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: AppProductRealEstateItem(
            type: ProductViewType.list,
          ),
        );
      },
      itemCount: 8,
    );

    if (_homePage?.recommend != null) {
      content = ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 16, right: 16),
        itemBuilder: (context, index) {
          final item = _homePage!.recommend[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AppProductRealEstateItem(
              item: item,
              onPressed: () {
                _onProductDetail(item);
              },
              type: ProductViewType.list,
            ),
          );
        },
        itemCount: _homePage!.recommend.length,
      );

      ///Empty
      if (_homePage!.recommend.isEmpty) {
        content = Container(
          alignment: Alignment.center,
          child: Text(
            Translate.of(context).translate('data_not_found'),
            style: Theme.of(context).textTheme.button,
          ),
        );
      }
    }

    ///Build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Translate.of(context).translate('recommend_for_you'),
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        Translate.of(context).translate('let_find_best_price'),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      _onProductList(null);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        Translate.of(context).translate('view_all'),
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        content,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: AppBarHomeRealEstate(
              maxHeight: 112 + MediaQuery.of(context).padding.top,
              minHeight: 60 + MediaQuery.of(context).padding.top,
              country: _homePage?.country,
              countrySelected: _countrySelected,
              onLocation: _onSelectCountry,
              onSearch: _onSearch,
            ),
            pinned: true,
            floating: true,
          ),
          CupertinoSliverRefreshControl(
            onRefresh: _onRefresh,
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 12),
                _buildLocation(),
                const SizedBox(height: 16),
                _buildPopular(),
                const SizedBox(height: 16),
                _buildRecommend(),
                const SizedBox(height: 24),
              ]),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: _chooseBusiness,
      ),
    );
  }
}
