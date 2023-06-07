import 'package:listar_flutter/models/model.dart';

class WishListFoodPageModel {
  final List<ProductFoodModel> list;

  WishListFoodPageModel(
    this.list,
  );

  factory WishListFoodPageModel.fromJson(dynamic json) {
    final Iterable refactorList = json ?? [];

    final list = refactorList.map((item) {
      return ProductFoodModel.fromJson(item);
    }).toList();

    return WishListFoodPageModel(list);
  }
}
