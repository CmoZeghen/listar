class ImageModel {
  final int id;
  final String image;

  ImageModel({
    required this.id,
    required this.image,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'] ?? 0,
      image: json['image'] ?? "Unknown",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
    };
  }
}
