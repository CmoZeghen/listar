class RateModel {
  final double one;
  final double two;
  final double three;
  final double four;
  final double five;
  final int range;
  final double avg;
  final int total;

  RateModel(
    this.one,
    this.two,
    this.three,
    this.four,
    this.five,
    this.range,
    this.avg,
    this.total,
  );

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      json['one'] ?? 0.0,
      json['two'] ?? 0.0,
      json['three'] ?? 0.0,
      json['four'] ?? 0.0,
      json['five'] ?? 0.0,
      json['range'] ?? 5,
      json['avg'] ?? 0.0,
      json['total'] ?? 5,
    );
  }
}
