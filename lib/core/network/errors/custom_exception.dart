class CustomException implements Exception {
  final int? statusCode;
  final String errorMessage;

  CustomException({
    required this.errorMessage,
    this.statusCode,
  });
}
