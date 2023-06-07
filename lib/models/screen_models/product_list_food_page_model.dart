import 'package:listar_flutter/models/model.dart';

class ProductListFoodPageModel {
  final List<ProductFoodModel> list;

  ProductListFoodPageModel(
    this.list,
  );

  factory ProductListFoodPageModel.fromJson(dynamic json) {
    return ProductListFoodPageModel(
      List.from(json ?? []).map((item) {
        return ProductFoodModel.fromJson(item);
      }).toList(),
    );
  }
}
