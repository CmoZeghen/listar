import 'package:listar_flutter/models/model.dart';

class WishListRealEstatePageModel {
  final List<ProductRealEstateModel> list;

  WishListRealEstatePageModel(
    this.list,
  );

  factory WishListRealEstatePageModel.fromJson(dynamic json) {
    final Iterable refactorList = json ?? [];

    final list = refactorList.map((item) {
      return ProductRealEstateModel.fromJson(item);
    }).toList();

    return WishListRealEstatePageModel(list);
  }
}
