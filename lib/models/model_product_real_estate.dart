import 'package:listar_flutter/models/model.dart';

class ProductRealEstateModel {
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
  final String description;
  final double price;
  final List<ImageModel> photo;
  final List<IconModel> service;
  final List<ProductRealEstateModel> nearly;
  final LocationModel? location;
  final UserModel? author;

  ProductRealEstateModel({
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
    required this.description,
    required this.price,
    required this.service,
    required this.photo,
    required this.nearly,
    required this.location,
    required this.author,
  });

  factory ProductRealEstateModel.fromJson(Map<String, dynamic> json) {
    LocationModel? location;
    UserModel? author;

    if (json['location'] != null) {
      location = LocationModel.fromJson(json['location']);
    }
    if (json['author'] != null) {
      author = UserModel.fromJson(json['author']);
    }
    return ProductRealEstateModel(
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
      description: json['description'] ?? 'Unknown',
      price: json['price'] ?? 0.0,
      service: (json['service'] as List).map((item) {
        return IconModel.fromJson(item);
      }).toList(),
      photo: (json['photo'] as List).map((item) {
        return ImageModel.fromJson(item);
      }).toList(),
      nearly: (json['nearly'] as List).map((item) {
        return ProductRealEstateModel.fromJson(item);
      }).toList(),
      location: location,
      author: author,
    );
  }
}
