import 'package:listar_flutter/models/model.dart';

class WishListEventPageModel {
  final List<ProductEventModel> list;

  WishListEventPageModel(
    this.list,
  );

  factory WishListEventPageModel.fromJson(dynamic json) {
    final Iterable refactorList = json ?? [];

    final list = refactorList.map((item) {
      return ProductEventModel.fromJson(item);
    }).toList();

    return WishListEventPageModel(list);
  }
}
