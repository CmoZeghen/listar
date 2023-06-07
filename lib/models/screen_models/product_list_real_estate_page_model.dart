import 'package:listar_flutter/models/model.dart';

class ProductListRealEstatePageModel {
  final List<ProductRealEstateModel> list;

  ProductListRealEstatePageModel(
    this.list,
  );

  factory ProductListRealEstatePageModel.fromJson(dynamic json) {
    return ProductListRealEstatePageModel(
      List.from(json ?? []).map((item) {
        return ProductRealEstateModel.fromJson(item);
      }).toList(),
    );
  }
}
