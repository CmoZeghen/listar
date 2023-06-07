import 'package:listar_flutter/models/model.dart';

class WishListPageModel {
  final List<ProductModel> list;

  WishListPageModel(
    this.list,
  );

  factory WishListPageModel.fromJson(dynamic json) {
    final Iterable refactorList = json ?? [];

    final list = refactorList.map((item) {
      return ProductModel.fromJson(item);
    }).toList();

    return WishListPageModel(list);
  }
}
