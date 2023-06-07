class ResultApiModel {
  final bool success;
  final String message;
  final dynamic data;
  final int code;

  ResultApiModel(
    this.success,
    this.message,
    this.data,
    this.code,
  );

  factory ResultApiModel.fromJson(Map<String, dynamic> json) {
    return ResultApiModel(
      json['success'] ?? false,
      json['message'] ?? 'Unknown',
      json['data'],
      json['code'] ?? 0,
    );
  }
}
