import 'package:listar_flutter/models/model.dart';

class ProductFoodModel {
  final int id;
  final String title;
  final String subtitle;
  final String image;
  final double rate;
  final num numRate;
  final String rateText;
  final String status;
  final String promotion;
  final String distance;
  final bool favorite;
  final String address;
  final String phone;
  final String email;
  final String website;
  final String description;
  final List<ImageModel> photo;
  final List<ProductFoodModel> related;
  final LocationModel? location;
  final UserModel? author;

  ProductFoodModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.rate,
    required this.numRate,
    required this.rateText,
    required this.status,
    required this.promotion,
    required this.distance,
    required this.favorite,
    required this.address,
    required this.phone,
    required this.email,
    required this.website,
    required this.description,
    required this.photo,
    required this.related,
    this.location,
    this.author,
  });

  factory ProductFoodModel.fromJson(Map<String, dynamic> json) {
    LocationModel? location;
    UserModel? author;

    if (json['location'] != null) {
      location = LocationModel.fromJson(json['location']);
    }
    if (json['author'] != null) {
      author = UserModel.fromJson(json['author']);
    }
    return ProductFoodModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown',
      subtitle: json['subtitle'] ?? 'Unknown',
      image: json['image'] ?? 'Unknown',
      rate: json['rate'] ?? 0,
      numRate: json['num_rate'] ?? 0,
      rateText: json['rate_text'] ?? 'Unknown',
      status: json['status'] ?? '',
      promotion: json['promotion'] ?? '',
      distance: json['distance'] ?? '',
      favorite: json['favorite'] ?? false,
      address: json['address'] ?? 'Unknown',
      phone: json['phone'] ?? 'Unknown',
      email: json['email'] ?? 'Unknown',
      website: json['website'] ?? 'Unknown',
      description: json['description'] ?? 'Unknown',
      photo: List.from(json['photo'] ?? []).map((item) {
        return ImageModel.fromJson(item);
      }).toList(),
      related: List.from(json['related'] ?? []).map((item) {
        return ProductFoodModel.fromJson(item);
      }).toList(),
      location: location,
      author: author,
    );
  }
}
