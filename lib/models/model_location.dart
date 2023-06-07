class LocationModel {
  final String title;
  final double lat;
  final double long;

  LocationModel({
    required this.title,
    required this.lat,
    required this.long,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      title: json['name'] ?? "Unknown",
      lat: json['lat'] ?? 0.0,
      long: json['long'] ?? 0.0,
    );
  }
}
