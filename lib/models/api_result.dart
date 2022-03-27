class ApiResult {
  final String status;
  final String message;
  final dynamic data;

  ApiResult({
    var this.status,
    var this.message,
    var this.data,
  });

  factory ApiResult.fromJson(Map<String, dynamic> json) {
    return ApiResult(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}