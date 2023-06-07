import 'package:listar_flutter/models/model.dart';

class ProductListEventPageModel {
  final List<ProductEventModel> list;

  ProductListEventPageModel(this.list);

  factory ProductListEventPageModel.fromJson(dynamic json) {
    return ProductListEventPageModel(
      List.from(json ?? []).map((item) {
        return ProductEventModel.fromJson(item);
      }).toList(),
    );
  }
}
