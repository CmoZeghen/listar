import 'package:listar_flutter/models/model.dart';

enum DetailViewStyle { basic, tab }

enum ProductViewType { small, gird, list, block, cardLarge, cardSmall }

class ProductModel {
  final int id;
  final String title;
  final String subtitle;
  final String image;
  final String createDate;
  final double rate;
  final num numRate;
  final String rateText;
  final String status;
  final bool favorite;
  final String address;
  final String phone;
  final String email;
  final String website;
  final String hour;
  final String description;
  final String priceRange;
  final List<ImageModel> photo;
  final List<HourModel>? hourDetail;
  final List<IconModel> service;
  final List<ProductModel> feature;
  final List<ProductModel> related;
  final LocationModel? location;
  final UserModel? author;
  final DetailViewStyle viewStyle;

  ProductModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.createDate,
    required this.rate,
    required this.numRate,
    required this.rateText,
    required this.status,
    required this.favorite,
    required this.address,
    required this.phone,
    required this.email,
    required this.website,
    required this.hour,
    required this.description,
    required this.priceRange,
    this.hourDetail,
    required this.service,
    required this.photo,
    required this.feature,
    required this.related,
    this.location,
    this.author,
    required this.viewStyle,
  });

  static DetailViewStyle _setViewStyle(json) {
    if (json['tab'] != null) {
      return DetailViewStyle.tab;
    }
    return DetailViewStyle.basic;
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    LocationModel? location;
    UserModel? author;

    if (json['location'] != null) {
      location = LocationModel.fromJson(json['location']);
    }
    if (json['author'] != null) {
      author = UserModel.fromJson(json['author']);
    }
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown',
      subtitle: json['subtitle'] ?? 'Unknown',
      image: json['image'] ?? 'Unknown',
      createDate: json['created_date'] ?? 'Unknown',
      rate: json['rate'] ?? 0,
      numRate: json['num_rate'] ?? 0,
      rateText: json['rate_text'] ?? 'Unknown',
      status: json['status'] ?? '',
      favorite: json['favorite'] ?? false,
      address: json['address'] ?? 'Unknown',
      phone: json['phone'] ?? 'Unknown',
      email: json['email'] ?? 'Unknown',
      website: json['website'] ?? 'Unknown',
      hour: json['hour'] ?? 'Unknown',
      description: json['description'] ?? 'Unknown',
      priceRange: json['price_range'] ?? 'Unknown',
      hourDetail: List.from(json['hour_detail'] ?? []).map((item) {
        return HourModel.fromJson(item);
      }).toList(),
      service: List.from(json['service'] ?? []).map((item) {
        return IconModel.fromJson(item);
      }).toList(),
      photo: List.from(json['photo'] ?? []).map((item) {
        return ImageModel.fromJson(item);
      }).toList(),
      feature: List.from(json['feature'] ?? []).map((item) {
        return ProductModel.fromJson(item);
      }).toList(),
      related: List.from(json['related'] ?? []).map((item) {
        return ProductModel.fromJson(item);
      }).toList(),
      location: location,
      author: author,
      viewStyle: _setViewStyle(json),
    );
  }
}
