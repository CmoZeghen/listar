import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/screens/home/home_category_item.dart';
import 'package:listar_flutter/screens/home/home_category_list.dart';
import 'package:listar_flutter/screens/home/home_sliver_app_bar.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';
import 'package:showcaseview/showcaseview.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  HomePageModel? _homePage;
  BusinessState _business = AppBloc.businessCubit.state;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  ///Fetch API
  void _loadData() async {
    final result = await Api.getHome();
    if (result.success) {
      setState(() {
        _homePage = HomePageModel.fromJson(result.data);
      });
      _animationController!.repeat(
        min: 0,
        max: 1,
        reverse: true,
        period: const Duration(seconds: 2),
      );
      ShowCaseWidget.of(context)!.startShowCase(
        [Application.globalKey['business']!, Application.globalKey['submit']!],
      );
    }
  }

  ///On refresh
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  ///On search
  void _onSearch() {
    Navigator.pushNamed(context, Routes.searchHistory);
  }

  ///On select category
  void _onCategory(CategoryModel item) {
    Navigator.pushNamed(context, Routes.listProduct, arguments: item);
  }

  ///On Open More
  void _onOpenMore() async {
    final item = await showModalBottomSheet<CategoryModel?>(
      context: context,
      builder: (BuildContext context) {
        return HomeCategoryList(
          category: _homePage!.category,
          onCategoryList: () {
            Navigator.pushNamed(context, Routes.category);
          },
          onCategory: (item) {
            Navigator.pop(context, item);
          },
        );
      },
    );
    if (item != null) {
      _onCategory(item);
    }
  }

  ///On navigate product detail
  void _onProductDetail(ProductModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
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

  ///Build category UI
  Widget _buildCategory() {
    if (_homePage == null) {
      return Wrap(
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: List.generate(8, (index) => index).map(
          (item) {
            return const HomeCategoryItem();
          },
        ).toList(),
      );
    }

    List<Widget> listBuild = _homePage!.category.map(
      (item) {
        return HomeCategoryItem(
          item: item,
          onPressed: () {
            _onCategory(item);
          },
        );
      },
    ).toList();

    ///Take 7 Item
    if (listBuild.length > 7) {
      listBuild = _homePage!.category.take(7).map(
        (item) {
          return HomeCategoryItem(
            item: item,
            onPressed: () {
              _onCategory(item);
            },
          );
        },
      ).toList();
    }

    ///More Category
    listBuild.add(HomeCategoryItem(
      item: CategoryModel.fromJson({
        "id": 9,
        "title": Translate.of(context).translate("more"),
        "icon": "more_horiz",
        "color": "#ff8a65",
        "type": "more"
      }),
      onPressed: () {
        _onOpenMore();
      },
    ));

    return Wrap(
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: listBuild,
    );
  }

  ///Build popular UI
  Widget _buildPopular() {
    if (_homePage == null) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: AppProductItem(
              type: ProductViewType.cardLarge,
            ),
          );
        },
        itemCount: 8,
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final item = _homePage!.popular[index];
        return Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: AppProductItem(
            item: item,
            type: ProductViewType.cardLarge,
            onPressed: () {
              _onProductDetail(item);
            },
          ),
        );
      },
      itemCount: _homePage!.popular.length,
    );
  }

  ///Build list recent
  Widget _buildList() {
    if (_homePage == null) {
      return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: AppProductItem(type: ProductViewType.small),
          );
        },
        itemCount: 8,
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = _homePage!.list[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: AppProductItem(
            item: item,
            onPressed: () {
              _onProductDetail(item);
            },
            type: ProductViewType.small,
          ),
        );
      },
      itemCount: _homePage!.list.length,
    );
  }

  ///Build choose business
  Widget? _buildBusiness() {
    return Showcase(
      key: Application.globalKey['business']!,
      description: Translate.of(context).translate('choose_your_business'),
      showArrow: true,
      targetShapeBorder: const CircleBorder(),
      targetPadding: const EdgeInsets.all(4),
      child: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.white,
        onPressed: _chooseBusiness,
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animationController!,
        ),
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
            delegate: AppBarHomeSliver(
              expandedHeight: 250,
              banners: _homePage?.banner,
              onSearch: _onSearch,
            ),
            pinned: true,
          ),
          CupertinoSliverRefreshControl(
            onRefresh: _onRefresh,
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: <Widget>[
                    const SizedBox(height: 12),
                    _buildCategory(),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                Translate.of(context).translate(
                                  'popular_location',
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                Translate.of(context).translate(
                                  'let_find_interesting',
                                ),
                                style: Theme.of(context).textTheme.bodyText2,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 190,
                      child: _buildPopular(),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                Translate.of(context).translate(
                                  'recent_location',
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                Translate.of(context).translate('what_happen'),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _buildList(),
                    ),
                    const SizedBox(height: 24),
                  ],
                )
              ]),
            ),
          )
        ],
      ),
      floatingActionButton: _buildBusiness(),
    );
  }
}
