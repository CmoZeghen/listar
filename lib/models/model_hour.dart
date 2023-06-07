class HourModel {
  final String title;
  final String time;

  HourModel(
    this.title,
    this.time,
  );

  factory HourModel.fromJson(Map<String, dynamic> json) {
    return HourModel(
      json['title'] ?? "Unknown",
      json['time'] ?? "Unknown",
    );
  }
}
