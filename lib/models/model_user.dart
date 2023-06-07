class UserModel {
  final int id;
  final String name;
  final String nickname;
  final String image;
  final String link;
  final String level;
  final String description;
  final String tag;
  final double rate;
  final List<Map<String, dynamic>> values;

  UserModel({
    required this.id,
    required this.name,
    required this.nickname,
    required this.image,
    required this.link,
    required this.level,
    required this.description,
    required this.tag,
    required this.rate,
    required this.values,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['full_name'] ?? 'Unknown',
      nickname: json['nickname'] ?? 'Unknown',
      image: json['photo'] ?? 'Unknown',
      link: json['url'] ?? 'Unknown',
      level: json['level'] ?? 'Unknown',
      description: json['description'] ?? 'Unknown',
      tag: json['tag'] ?? 'Unknown',
      rate: json['rate'] ?? 0.0,
      values: List<Map<String, dynamic>>.from(json['values'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': name,
      'nickname': nickname,
      'photo': image,
      'url': link,
      'level': level,
      'description': description,
      'tag': tag,
      'rate': rate,
      'values': values,
    };
  }
}
