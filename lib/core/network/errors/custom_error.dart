class CustomError {
  final int? statusCode;
  final String errorMessage;

  CustomError({
    required this.errorMessage,
    this.statusCode,
  });
}
