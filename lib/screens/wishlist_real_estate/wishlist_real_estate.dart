import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class WishListRealEstate extends StatefulWidget {
  const WishListRealEstate({Key? key}) : super(key: key);

  @override
  _WishListRealEstateState createState() {
    return _WishListRealEstateState();
  }
}

class _WishListRealEstateState extends State<WishListRealEstate> {
  WishListRealEstatePageModel? _listPage;

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
    final result = await Api.getWishList();
    if (result.success) {
      setState(() {
        _listPage = WishListRealEstatePageModel.fromJson(result.data);
      });
    }
  }

  ///On refresh
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  ///On navigate product detail
  void _onProductDetail(ProductRealEstateModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
  }

  ///Build list
  Widget _buildList() {
    if (_listPage == null) {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 15,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AppProductRealEstateItem(
              type: ProductViewType.small,
            ),
          );
        },
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _listPage!.list.length,
        itemBuilder: (context, index) {
          final item = _listPage!.list[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AppProductRealEstateItem(
              onPressed: () {
                _onProductDetail(item);
              },
              item: item,
              type: ProductViewType.small,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('wish_list'),
        ),
      ),
      body: SafeArea(
        child: _buildList(),
      ),
    );
  }
}
