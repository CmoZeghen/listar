import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

import 'appbar_home_event.dart';

class HomeEvent extends StatefulWidget {
  const HomeEvent({Key? key}) : super(key: key);

  @override
  _HomeEventState createState() {
    return _HomeEventState();
  }
}

class _HomeEventState extends State<HomeEvent> {
  HomeEventPageModel? _homePage;
  BusinessState _business = AppBloc.businessCubit.state;

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
    final result = await Api.getHome();
    if (result.success) {
      setState(() {
        _homePage = HomeEventPageModel.fromJson(result.data);
      });
    }
  }

  ///On refresh
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  ///On navigate list product
  void _onProductList(CategoryModel? item) {
    Navigator.pushNamed(
      context,
      Routes.listProduct,
      arguments: item,
    );
  }

  ///On navigate product detail
  void _onProductDetail(ProductEventModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
  }

  ///On navigate notification
  void _onNotification() {
    Navigator.pushNamed(context, Routes.notification);
  }

  ///On search
  void _onSearch() {
    Navigator.pushNamed(context, Routes.searchHistory);
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

  ///Build list category
  Widget _buildCategory() {
    if (_homePage == null) {
      return ListView.builder(
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
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 10,
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: 8,
      );
    }

    if (_homePage!.categorys.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          Translate.of(context).translate('data_not_found'),
          style: Theme.of(context).textTheme.button,
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(left: 8, right: 8),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final item = _homePage!.categorys[index];
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
                    color: item.color.withOpacity(0.3),
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Icon(
                    item.icon,
                    size: 32,
                    color: item.color,
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
        return const SizedBox(width: 8);
      },
      itemCount: _homePage!.categorys.length,
    );
  }

  ///Build Feature List
  Widget _buildFeature() {
    Widget content = ListView.builder(
      padding: const EdgeInsets.only(left: 8, right: 8),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          width: 200,
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: AppProductEventItem(
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
          final item = _homePage!.features[index];
          return Container(
            padding: const EdgeInsets.only(left: 8, right: 8),
            width: 200,
            child: AppProductEventItem(
              item: item,
              onPressed: () {
                _onProductDetail(item);
              },
              type: ProductViewType.gird,
            ),
          );
        },
        itemCount: _homePage!.features.length,
      );

      ///Empty
      if (_homePage!.features.isEmpty) {
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
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translate.of(context).translate('feature_event'),
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                Translate.of(context).translate('let_find_around'),
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 250,
          child: content,
        )
      ],
    );
  }

  ///Build news
  Widget _buildNews() {
    Widget content = ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: AppProductEventItem(
            type: ProductViewType.small,
          ),
        );
      },
      itemCount: 8,
    );

    if (_homePage != null) {
      content = ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final item = _homePage!.news[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: AppProductEventItem(
              item: item,
              onPressed: () {
                _onProductDetail(item);
              },
              type: ProductViewType.small,
            ),
          );
        },
        itemCount: _homePage!.news.length,
      );

      ///Empty
      if (_homePage!.news.isEmpty) {
        content = Container(
          alignment: Alignment.center,
          child: Text(
            Translate.of(context).translate('date_not_found'),
            style: Theme.of(context).textTheme.button,
          ),
        );
      }
    }

    ///Build
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
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
                    Translate.of(context).translate('new_event'),
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
          const SizedBox(height: 4),
          content,
        ],
      ),
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
            delegate: AppBarHomeEvent(
              maxHeight: 124 + MediaQuery.of(context).padding.top,
              minHeight: 64 + MediaQuery.of(context).padding.top,
              today: DateTime.now(),
              onNotification: _onNotification,
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
                const SizedBox(height: 8),
                SizedBox(
                  height: 80,
                  child: _buildCategory(),
                ),
                const SizedBox(height: 16),
                _buildFeature(),
                const SizedBox(height: 8),
                _buildNews(),
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
