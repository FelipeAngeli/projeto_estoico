class AppError {
  final String message;
  final ErrorCode code;

  AppError({required this.message, this.code = ErrorCode.generic});

  @override
  String toString() => 'Error: $message (Code: $code)';
}

enum ErrorCode {
  generic,
  network,
  parsing,
  notFound,
}
