import 'package:listar_flutter/models/model.dart';

class ProductDetailRealEstatePageModel {
  final ProductRealEstateModel product;

  ProductDetailRealEstatePageModel({
    required this.product,
  });

  factory ProductDetailRealEstatePageModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailRealEstatePageModel(
      product: ProductRealEstateModel.fromJson(json),
    );
  }
}
