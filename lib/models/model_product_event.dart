import 'package:listar_flutter/models/model.dart';

class ProductEventModel {
  final int id;
  final String title;
  final String subtitle;
  final String image;
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
  final DateTime date;
  final String time;
  final List<ImageModel> photo;
  final List<UserModel> userFavorite;
  final List<ProductEventModel> nearly;
  final LocationModel? location;
  final UserModel? author;

  ProductEventModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
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
    required this.date,
    required this.time,
    required this.photo,
    required this.userFavorite,
    required this.nearly,
    this.location,
    this.author,
  });

  factory ProductEventModel.fromJson(Map<String, dynamic> json) {
    LocationModel? location;
    UserModel? author;

    if (json['location'] != null) {
      location = LocationModel.fromJson(json['location']);
    }
    if (json['author'] != null) {
      author = UserModel.fromJson(json['author']);
    }
    return ProductEventModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown',
      subtitle: json['subtitle'] ?? 'Unknown',
      image: json['image'] ?? 'Unknown',
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
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      time: json['time'] ?? 'Unknown',
      userFavorite: List.from(json['liked'] ?? []).map((item) {
        return UserModel.fromJson(item);
      }).toList(),
      photo: List.from(json['photo'] ?? []).map((item) {
        return ImageModel.fromJson(item);
      }).toList(),
      nearly: List.from(json['nearly'] ?? []).map((item) {
        return ProductEventModel.fromJson(item);
      }).toList(),
      location: location,
      author: author,
    );
  }
}
