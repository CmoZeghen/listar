import 'package:listar_flutter/models/model.dart';

class ProductDetailPageModel {
  final ProductModel product;
  final List<TabModel>? tab;

  ProductDetailPageModel({
    required this.product,
    this.tab,
  });

  factory ProductDetailPageModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailPageModel(
      product: ProductModel.fromJson(json),
      tab: List.from(json['tab'] ?? []).map((item) {
        return TabModel.fromJson(item);
      }).toList(),
    );
  }
}
